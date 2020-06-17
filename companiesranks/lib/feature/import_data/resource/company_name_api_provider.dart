import 'dart:async';

import 'package:companiesranks/common/http/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class CompanyNameApiProvider {
  CompanyNameApiProvider({@required this.apiProvider}) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  Future<dynamic> fetchCompanyName() {
    return apiProvider.get('/companiesNames');
  }

  Future<dynamic> sendCompanyData(FormData body) {
    return apiProvider.post('/importData', body);
  }
}
