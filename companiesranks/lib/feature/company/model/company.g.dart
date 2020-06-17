// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    json['companyId'] as int,
    json['score'] as int,
    json['reportId'] as int,
    json['debts'] as int,
    json['invoices'] as int,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'reportId': instance.reportId,
      'companyId': instance.companyId,
      'score': instance.score,
      'invoices': instance.invoices,
      'debts': instance.debts,
    };
