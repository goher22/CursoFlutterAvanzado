import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  // final user; ???
  Future login(String email, String password) async {
    try {
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

      print(resp.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
