class ApiResponse {
  ApiResponse(
    this.data,
    this.errors, {
    required this.statusCode,
    required this.message,
  });

  dynamic data;
  final int statusCode;
  final String message;
  String? errors;

  ApiResponse.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'],
        message = json['message'] {
    if (json.containsKey('data')) {
      data = json['data'];
    }
    if (json.containsKey('errors')) {
      errors = json['errors'];
    }
  }
}
