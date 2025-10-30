import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import '../config/constants.dart';

class AuthService {
  static Future<Map<String,dynamic>> login(String email, String password) async {
    final res = await ApiService.post('${API.AUTH}/login', {'email': email, 'password': password});
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      final sp = await SharedPreferences.getInstance();
      await sp.setString('token', body['token']);
      await sp.setString('user', jsonEncode(body['user']));
      return {'ok': true, 'user': body['user']};
    }
    return {'ok': false, 'error': body['message'] ?? 'Login failed'};
  }

  static Future<Map<String,dynamic>> register(Map payload) async {
    final res = await ApiService.post('${API.AUTH}/register', payload);
    final body = jsonDecode(res.body);
    if (res.statusCode == 201) return {'ok': true, 'data': body};
    return {'ok': false, 'error': body['message'] ?? 'Register failed'};
  }

  static Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    await sp.remove('user');
  }
}
