import 'dart:io';

import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final String? token;
  final Dio dio;

  ApiInterceptor(
    this.token,
    this.dio,
  );
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers
        .addEntries({HttpHeaders.authorizationHeader: "Bearer $token"}.entries);
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      if (err.response?.statusCode == 401) {
        return;
      }
    }
  }
}
