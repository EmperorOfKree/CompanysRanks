// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_rank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyRank _$CompanyRankFromJson(Map<String, dynamic> json) {
  return CompanyRank(
    json['companyDebts'] as int,
    json['companyId'] as int,
    json['companyInvoices'] as int,
    json['companyName'] as String,
    (json['companyRank'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CompanyRankToJson(CompanyRank instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'companyRank': instance.companyRank,
      'companyInvoices': instance.companyInvoices,
      'companyDebts': instance.companyDebts,
    };
