import 'package:http/http.dart' as http;

import '../global/environment.dart';
import '../models/user.dart';
import '../models/user_resposen.dart';
import 'auth_service.dart';

class UserService {
  Future<List<User>> getUsers() async {
    try {
      final token = await AuthService.getToken();
      var url = Uri.http(Environments.apiURL, 'api/user');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      final userResponse = usersResponseFromJson(resp.body);
      return userResponse.users;
    } catch (e) {
      return [];
    }
  }
}
