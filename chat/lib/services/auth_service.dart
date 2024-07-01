import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../global/environment.dart';
import '../models/login_response.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  late User user;

  final _storage = new FlutterSecureStorage();

  bool _authentication = false;
  bool get authentication => _authentication;
  set authentication(bool value) {
    _authentication = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: "token");
    return token ?? "";
  }

  static Future<void> deleteToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "token");
  }

  Future login(String email, String password) async {
    try {
      authentication = true;
      final data = {
        'email': email,
        'password': password,
      };

      var url = Uri.http(Environments.apiURL, 'api/login');

      final resp = await http.post(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        user = loginResponse.user;

        await _saveToken(loginResponse.token);
      } else {
        throw "Error";
      }
    } catch (e) {
      rethrow;
    } finally {
      authentication = false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
