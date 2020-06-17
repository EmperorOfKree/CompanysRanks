import 'package:companiesranks/common/http/response.dart';
import 'package:bloc/bloc.dart';
import 'package:companiesranks/feature/company/model/company.dart';
import 'package:companiesranks/feature/company/resource/company_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository companyRepository;

  CompanyBloc({@required this.companyRepository})
      : assert(companyRepository != null);

  @override
  CompanyState get initialState => CompanyEmpty();

  @override
  Stream<Transition<CompanyEvent, CompanyState>> transformEvents(
    Stream<CompanyEvent> events,
    next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        const Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<CompanyState> mapEventToState(CompanyEvent event) async* {
    final CompanyState currentState = state;

    if (event is Fetch) {
      if (currentState is CompanyEmpty) {
        yield CompanyLoading();
        final List<Company> companyReports = await _fetchCompany(event.companyId);
        yield CompanyLoaded(companyReports: companyReports);
        return;
      }
      if (currentState is CompanyLoaded) {
        final List<Company> posts = await _fetchCompany(event.companyId);
        yield posts.isEmpty ? currentState.copyWith() : CompanyLoaded(companyReports: currentState.companyReports + posts);
      }
    }
  }

  Future<List<Company>> _fetchCompany(String companyId) async {
    final response = await companyRepository.fetchCompany(companyId);
    if (response.status == Status.ConnectivityError) {}
    if (response.status == Status.Success) {
      return response.data;
    }

    return [];
  }
}
