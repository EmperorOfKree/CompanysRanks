import 'dart:async';

import 'package:companiesranks/common/http/api_provider.dart';
import 'package:meta/meta.dart';

class CompanyRankApiProvider {
  CompanyRankApiProvider({@required this.apiProvider}) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  Future<dynamic> fetchCompanyRank() {
    return apiProvider.get('/companies');
  }
}
