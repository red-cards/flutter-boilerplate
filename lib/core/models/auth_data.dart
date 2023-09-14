class AuthData {
  const AuthData({required this.token, required this.jwtToken});

  final String token;
  final String jwtToken;
  AuthData.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        jwtToken = json['jwtToken'];
}
