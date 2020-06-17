import 'dart:async';

import 'package:companiesranks/common/http/api_provider.dart';
import 'package:meta/meta.dart';

class CompanyApiProvider {
  CompanyApiProvider({@required this.apiProvider}) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  Future<dynamic> fetchCompany(String companyId) {
    return apiProvider.get("/company_reports/" + companyId);
  }
}
