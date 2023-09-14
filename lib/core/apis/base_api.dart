import 'package:boilerplate_flutter/core/models/api_response.dart';
import 'package:boilerplate_flutter/core/services/dio/dio_provider.dart';
import 'package:riverpod/riverpod.dart';

abstract class BaseApi<T> extends StateNotifier<T?> {
  BaseApi(this._ref) : super(null) {
    load();
  }
  String endpoint = '';
  final Ref _ref;

  Future<void> load() async {
    final dio = _ref.watch(dioProvider);
    final apires = await dio.get(endpoint);

    if (apires.statusCode != 200) {
      return;
    }
    final res = ApiResponse.fromJson(apires.data);
    // get list from Api to temp
    // final temp = await res.data.map((value) => Transaction.fromJson(value)).toList();

    // set state list to temp
    // state = ListParkingState.list(temp.cast<Transaction>());
  }
}
