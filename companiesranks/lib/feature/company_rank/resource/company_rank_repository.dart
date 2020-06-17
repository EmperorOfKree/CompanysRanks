import 'package:companiesranks/common/http/api_provider.dart';
import 'package:companiesranks/common/http/response.dart';
import 'package:companiesranks/common/utils/internet_check.dart';
import 'package:companiesranks/feature/company_rank/model/company_rank.dart';
import 'package:companiesranks/feature/company_rank/resource/company_rank_api_provider.dart';
import 'package:meta/meta.dart';

class CompanyRankRepository {
  ApiProvider apiProvider;
  CompanyRankApiProvider companyRankApiProvider;
  InternetCheck internetCheck;

  CompanyRankRepository({@required this.apiProvider, @required this.internetCheck}) {
    companyRankApiProvider = CompanyRankApiProvider(apiProvider: apiProvider);
  }

  Future<DataResponse<List<CompanyRank>>> fetchCompanyRank() async {
    final response = await companyRankApiProvider.fetchCompanyRank();

    if (response == null) {
      return DataResponse.connectivityError();
    }
    if (response['error'] == null) {
      final List<CompanyRank> _companiesRanks = (response['data'] as List)?.map((dynamic e) {
        return e == null ? null : CompanyRank.fromJson(e as Map<String, dynamic>);
      })?.toList();

      return DataResponse.success(_companiesRanks);

    } else {
      return DataResponse.error("Error");
    }
  }
}
