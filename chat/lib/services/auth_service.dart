import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/login_response.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _authentication = false;
  bool get authentication => _authentication;
  set authentication(bool value) {
    _authentication = value;
    notifyListeners();
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
      } else {
        throw "Error";
      }
    } catch (e) {
      rethrow;
    } finally {
      authentication = false;
    }
  }
}
