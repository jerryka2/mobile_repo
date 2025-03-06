import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sprint4_fix/app/constants/api_endpoint.dart';
import 'package:sprint4_fix/core/network/dio_error_incterceptor.dart';

class ApiService {
  final Dio _dio;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: false))
      ..options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
  }
}
