part of 'company_rank_bloc.dart';

abstract class CompanyRankState extends Equatable {
  const CompanyRankState();

  @override
  List<Object> get props => [];
}

class CompanyRankEmpty extends CompanyRankState {}

class CompanyRankLoading extends CompanyRankState {}

class CompanyRankError extends CompanyRankState {}

class CompanyRankLoaded extends CompanyRankState {
  final List<CompanyRank> companiesRanks;

  const CompanyRankLoaded({this.companiesRanks});

  CompanyRankLoaded copyWith({List<CompanyRank> posts}) {
    return CompanyRankLoaded(companiesRanks: posts ?? this.companiesRanks);
  }

  @override
  List<Object> get props => [companiesRanks];

  @override
  String toString() => 'PostLoaded { posts: ${companiesRanks.length} }';
}
