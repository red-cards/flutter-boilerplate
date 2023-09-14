import 'package:boilerplate_flutter/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final authProvider = Provider<Dio>((ref) {
  final BaseOptions option = BaseOptions(
    responseType: ResponseType.json,
    baseUrl: BASE_URL,
    validateStatus: (_) => true,
  );
  final Dio dio = Dio(option);

  ref.onDispose(dio.close);

  return dio;
});
