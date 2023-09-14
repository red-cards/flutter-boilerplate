import 'dart:convert';
import 'dart:io';

import 'package:boilerplate_flutter/core/services/dio/auth_provider.dart';
import 'package:boilerplate_flutter/core/utils/constants.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_response.dart';
import '../models/token_auth.dart';

class TokenNotifier extends StateNotifier<TokenAuth> {
  TokenNotifier(this._ref) : super(TokenAuth(null, null)) {
    load();
  }

  final Ref _ref;

  Future<void> load() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(TOKEN);
    final jwtToken = pref.getString(JWTTOKEN);

    state = TokenAuth(token, jwtToken);
  }

  Future<int> login({username, password}) async {
    final pref = await SharedPreferences.getInstance();

    final dio = _ref.watch(authProvider);
    dio.options.headers.addEntries({
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
    }.entries);

    // if needed to add query params
    // dio.options.queryParameters.addEntries({'remember_me': 'true'}.entries);

    final res = await dio.post('parkir/auth/login');
    final authRes = AuthResponse.fromJson(res.data);

    if (authRes.statusCode == 200) {
      await pref.setString(TOKEN, authRes.data!.token);
      await pref.setString(JWTTOKEN, authRes.data!.jwtToken);
      state = TokenAuth(authRes.data!.token, authRes.data!.jwtToken);
    }
    return authRes.statusCode;
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(TOKEN);
    await pref.remove(JWTTOKEN);

    state = TokenAuth(null, null);
  }
}

final tokenAuthProvider = StateNotifierProvider<TokenNotifier, TokenAuth>(
    (ref) => TokenNotifier(ref));
