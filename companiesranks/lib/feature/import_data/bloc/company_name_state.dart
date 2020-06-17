part of 'company_name_bloc.dart';

abstract class CompanyNameState extends Equatable {
  const CompanyNameState();

  @override
  List<Object> get props => [];
}

class CompanyNameEmpty extends CompanyNameState {}

class CompanyNameLoading extends CompanyNameState {}

class CompanyNameError extends CompanyNameState {}

class CompanyNameLoaded extends CompanyNameState {
  final List<CompanyName> companyNames;

  const CompanyNameLoaded({this.companyNames});

  CompanyNameLoaded copyWith({List<CompanyName> posts}) {
    return CompanyNameLoaded(companyNames: posts ?? this.companyNames);
  }

  @override
  List<Object> get props => [companyNames];

  @override
  String toString() => 'PostLoaded { posts: ${companyNames.length} }';
}
