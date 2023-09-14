import 'package:boilerplate_flutter/core/apis/token.dart';
import 'package:boilerplate_flutter/core/services/interceptors/api_interceptor.dart';
import 'package:boilerplate_flutter/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final token = ref.watch(tokenAuthProvider).token;
  final BaseOptions option = BaseOptions(
    baseUrl: '$BASE_URL/parkir/api/',
    responseType: ResponseType.json,
    followRedirects: false,
    validateStatus: (_) => true,
  );
  final Dio dio = Dio(option);

  ref.onDispose(dio.close);

  return dio
    ..interceptors.addAll([
      ApiInterceptor(token, dio),
    ]);
});
