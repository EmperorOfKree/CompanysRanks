import 'package:companiesranks/common/http/response.dart';
import 'package:bloc/bloc.dart';
import 'package:companiesranks/feature/import_data/model/company_name.dart';
import 'package:companiesranks/feature/import_data/resource/company_name_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'company_name_event.dart';
part 'company_name_state.dart';

class CompanyNameBloc extends Bloc<CompanyNameEvent, CompanyNameState> {
  final CompanyNameRepository companyNameRepository;

  CompanyNameBloc({@required this.companyNameRepository})
      : assert(companyNameRepository != null);

  @override
  CompanyNameState get initialState => CompanyNameEmpty();



  @override
  Stream<Transition<CompanyNameEvent, CompanyNameState>> transformEvents(
    Stream<CompanyNameEvent> events,
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
  Stream<CompanyNameState> mapEventToState(CompanyNameEvent event) async* {
    final CompanyNameState currentState = state;

    if (event is Fetch) {
      if (currentState is CompanyNameEmpty) {
        yield CompanyNameLoading();
        final List<CompanyName> companyNames = await _fetchCompanyName();
        yield CompanyNameLoaded(companyNames: companyNames);
        return;
      }

      if (currentState is CompanyNameLoaded) {
        final List<CompanyName> posts = await _fetchCompanyName();
        yield posts.isEmpty ? currentState.copyWith() : CompanyNameLoaded(companyNames: currentState.companyNames + posts);
      }
    
    } else if (event is Post) {
      if (currentState is CompanyNameLoaded) {
        final String posts = await _sendCompanyData(event.data);
        yield posts.isEmpty ? currentState.copyWith() : CompanyNameLoaded(companyNames: currentState.companyNames);
      }
    }
  }

  Future<List<CompanyName>> _fetchCompanyName() async {
    final response = await companyNameRepository.fetchCompanyName();
    if (response.status == Status.ConnectivityError) {}
    if (response.status == Status.Success) {
      return response.data;
    }

    return [];
  }

  Future<String> _sendCompanyData(FormData body) async {
    final response = await companyNameRepository.sendCompanyData(body);
    if (response.status == Status.ConnectivityError) {}
    if (response.status == Status.Success) {
      return response.data;
    }

    return "";
  }

  sendCompanyData(FormData body) {
    companyNameRepository.sendCompanyData(body);
  }
}
