import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_name.g.dart';

@JsonSerializable()
class CompanyName extends Equatable {
  final int companyId;
  final String companyName;

  CompanyName(this.companyId, this.companyName);

  factory CompanyName.fromJson(Map<String, dynamic> json) => _$CompanyNameFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyNameToJson(this);

  // Equatable
  @override
  List<Object> get props => [companyId, companyName];
}