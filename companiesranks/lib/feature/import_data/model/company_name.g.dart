// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyName _$CompanyNameFromJson(Map<String, dynamic> json) {
  return CompanyName(
    json['companyId'] as int,
    json['companyName'] as String,
  );
}

Map<String, dynamic> _$CompanyNameToJson(CompanyName instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'companyName': instance.companyName,
    };
