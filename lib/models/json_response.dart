class LoginResponse {
  String accessToken;
  String tokenType;
  String expiresAt;

  LoginResponse(this.accessToken, this.tokenType, this.expiresAt);

  factory LoginResponse.fromJson(Map<String, dynamic> josnResponse) {
    return LoginResponse(josnResponse['access_token'],
        josnResponse['token_type'], josnResponse['expires_at']);
  }
}