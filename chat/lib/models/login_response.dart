import 'dart:convert';

import 'user.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool ok;
  User user;
  String token;

  LoginResponse({
    required this.ok,
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        user: User.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": user.toJson(),
        "token": token,
      };
}
