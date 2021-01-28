class LoginModel {
  final String userId;
  final String token;

  LoginModel({this.userId, this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(userId: json['id'], token: json['token']);
  }

  factory LoginModel.set(String userId, String token) {
    return LoginModel(userId: userId, token: token);
  }
}
