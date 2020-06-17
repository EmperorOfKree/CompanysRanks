part of 'company_bloc.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object> get props => [];
}

class CompanyEmpty extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanyError extends CompanyState {}

class CompanyLoaded extends CompanyState {
  final List<Company> companyReports;

  const CompanyLoaded({this.companyReports});

  CompanyLoaded copyWith({List<Company> posts}) {
    return CompanyLoaded(companyReports: posts ?? this.companyReports);
  }

  @override
  List<Object> get props => [companyReports];

  @override
  String toString() => 'PostLoaded { posts: ${companyReports.length} }';
}
