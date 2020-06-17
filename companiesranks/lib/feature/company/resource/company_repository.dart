import 'package:companiesranks/common/http/api_provider.dart';
import 'package:companiesranks/common/http/response.dart';
import 'package:companiesranks/common/utils/internet_check.dart';
import 'package:companiesranks/feature/company/model/company.dart';
import 'package:companiesranks/feature/company/resource/company_api_provider.dart';
import 'package:meta/meta.dart';

class CompanyRepository {
  ApiProvider apiProvider;
  CompanyApiProvider companyApiProvider;
  InternetCheck internetCheck;

  CompanyRepository({@required this.apiProvider, @required this.internetCheck}) {
    companyApiProvider = CompanyApiProvider(apiProvider: apiProvider);
  }

  Future<DataResponse<List<Company>>> fetchCompany(String companyId) async {
    final response = await companyApiProvider.fetchCompany(companyId);

    if (response == null) {
      return DataResponse.connectivityError();
    }
    if (response['error'] == null) {
      final List<Company> _tiposInvestimentos = (response['data'] as List)?.map((dynamic e) {
        return e == null ? null : Company.fromJson(e as Map<String, dynamic>);
      })?.toList();

      return DataResponse.success(_tiposInvestimentos);

    } else {
      return DataResponse.error("Error");
    }
  }
}
