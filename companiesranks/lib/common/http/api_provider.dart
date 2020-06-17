import 'dart:async';
import 'dart:io';

import 'package:companiesranks/common/constants/env.dart';
import 'package:dio/dio.dart';

import 'custom_exception.dart';

class ApiProvider {
  String token = '';
  Dio _dio;

  ApiProvider(Env env) {
    BaseOptions options = new BaseOptions(
      baseUrl: env.baseUrl,
    );
    _dio = this._addInterceptors(new Dio(options), env.debug);
  }

  Dio _addInterceptors(Dio dio, debug) {
    if (debug) {
      dio..interceptors.add(LogInterceptor(responseBody: false));
    }

    return dio;
  }

  Future<Map<String, dynamic>> post(String path, dynamic body) async {
    dynamic responseJson;
    try {
      final dynamic response = await _dio.post(path, data: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String path, {dynamic query}) async {
    dynamic responseJson;
    try {
      final dynamic response = await _dio.get(path, queryParameters: query);
      responseJson = _response(response);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet connection: $e');
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        final dynamic responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
