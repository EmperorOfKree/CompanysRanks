part of 'company_rank_bloc.dart';

abstract class CompanyRankEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends CompanyRankEvent {}
