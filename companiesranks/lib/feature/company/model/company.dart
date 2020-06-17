import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company extends Equatable {
  final int reportId;
  final int companyId;
  final int score;
  final int invoices;
  final int debts;

  Company(this.companyId, this.score, this.reportId, this.debts, this.invoices);

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  // Equatable
  @override
  List<Object> get props => [companyId, score, reportId, invoices, debts];
}