import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_rank.g.dart';

@JsonSerializable()
class CompanyRank extends Equatable {
  final int companyId;
  final String companyName;
  final double companyRank;
  final int companyInvoices;
  final int companyDebts;

  CompanyRank(this.companyDebts, this.companyId, this.companyInvoices, this.companyName, this.companyRank);

  factory CompanyRank.fromJson(Map<String, dynamic> json) => _$CompanyRankFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyRankToJson(this);

  // Equatable
  @override
  List<Object> get props => [companyDebts, companyId, companyInvoices, companyName, companyRank];
}