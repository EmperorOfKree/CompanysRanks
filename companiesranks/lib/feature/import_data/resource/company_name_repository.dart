import 'package:companiesranks/common/http/api_provider.dart';
import 'package:companiesranks/common/http/response.dart';
import 'package:companiesranks/common/utils/internet_check.dart';
import 'package:companiesranks/feature/import_data/model/company_name.dart';
import 'package:companiesranks/feature/import_data/resource/company_name_api_provider.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class CompanyNameRepository {
  ApiProvider apiProvider;
  CompanyNameApiProvider companyNameApiProvider;
  InternetCheck internetCheck;

  CompanyNameRepository({@required this.apiProvider, @required this.internetCheck}) {
    companyNameApiProvider = CompanyNameApiProvider(apiProvider: apiProvider);
  }

  Future<DataResponse<List<CompanyName>>> fetchCompanyName() async {
    final response = await companyNameApiProvider.fetchCompanyName();

    if (response == null) {
      return DataResponse.connectivityError();
    }
    if (response['error'] == null) {
      final List<CompanyName> _companyNames = (response['data'] as List)?.map((dynamic e) {
        return e == null ? null : CompanyName.fromJson(e as Map<String, dynamic>);
      })?.toList();

      return DataResponse.success(_companyNames);

    } else {
      return DataResponse.error("Error");
    }
  }

  Future<DataResponse<String>> sendCompanyData(FormData body) async {
    final response = await companyNameApiProvider.sendCompanyData(body);

    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response['error'] == null) {
      return DataResponse.success("Arquivo importado com sucesso");

    } else {
      return DataResponse.error("Error");
    }
  }
}
