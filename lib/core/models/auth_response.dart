import 'auth_data.dart';

class AuthResponse {
  AuthResponse(
    this.data,
    this.errors, {
    required this.statusCode,
    required this.message,
  });

  AuthData? data;
  final int statusCode;
  final String message;
  String? errors;

  AuthResponse.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'],
        message = json['message'] {
    if (json.containsKey('data')) {
      data = AuthData.fromJson(json['data']);
    }
    if (json.containsKey('errors')) {
      errors = json['errors'];
    }
  }
}
