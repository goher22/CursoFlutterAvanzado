import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/message_response.dart';
import '../models/user.dart';
import 'auth_service.dart';

class ChatService with ChangeNotifier {
  late User userFrom;

  Future getChat(String userId) async {
    final token = await AuthService.getToken();
    var url = Uri.http(Environments.apiURL, 'api/message/$userId');
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'x-token': token,
    });

    final messageResp = messageResponseFromJson(resp.body);
    return messageResp.message;
  }
}
