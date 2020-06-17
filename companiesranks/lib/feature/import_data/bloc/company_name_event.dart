part of 'company_name_bloc.dart';

abstract class CompanyNameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends CompanyNameEvent {}

class Post extends CompanyNameEvent {
  final FormData data;
  Post(this.data);

  @override
  String toString() => 'CompanyEvent { query: $data }';
}
