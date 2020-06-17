part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends CompanyEvent {
  final String companyId;
  const Fetch(this.companyId);

  @override
  String toString() => 'CompanyEvent { query: $companyId }';
}
