import 'package:companiesranks/common/http/response.dart';
import 'package:companiesranks/feature/company_rank/model/company_rank.dart';
import 'package:companiesranks/feature/company_rank/resource/company_rank_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'company_rank_event.dart';
part 'company_rank_state.dart';

class CompanyRankBloc extends Bloc<CompanyRankEvent, CompanyRankState> {
  final CompanyRankRepository companyRankRepository;

  CompanyRankBloc({@required this.companyRankRepository})
      : assert(companyRankRepository != null);

  @override
  CompanyRankState get initialState => CompanyRankEmpty();

  @override
  Stream<Transition<CompanyRankEvent, CompanyRankState>> transformEvents(
    Stream<CompanyRankEvent> events,
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
  Stream<CompanyRankState> mapEventToState(CompanyRankEvent event) async* {
    final CompanyRankState currentState = state;

    if (event is Fetch) {
      if (currentState is CompanyRankEmpty) {
        yield CompanyRankLoading();
        final List<CompanyRank> companiesRanks = await _fetchCompanyRank();
        yield CompanyRankLoaded(companiesRanks: companiesRanks);
        return;
      }
      if (currentState is CompanyRankLoaded) {
        final List<CompanyRank> posts = await _fetchCompanyRank();
        yield posts.isEmpty
            ? currentState.copyWith()
            : CompanyRankLoaded(
                companiesRanks: currentState.companiesRanks + posts);
      }
    }
  }

  Future<List<CompanyRank>> _fetchCompanyRank() async {
    final response = await companyRankRepository.fetchCompanyRank();
    if (response.status == Status.ConnectivityError) {}
    if (response.status == Status.Success) {
      return response.data;
    }

    return [];
  }
}
