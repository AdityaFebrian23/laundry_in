import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future<String?> _getToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString('token');
  }

  static Future<http.Response> get(String path, {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    final token = await _getToken();
    final uri = Uri.parse(path).replace(queryParameters: query?.map((k,v)=>MapEntry(k,v.toString())));
    final h = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      if (headers != null) ...headers
    };
    return http.get(uri, headers: h);
  }

  static Future<http.Response> post(String path, Map body, {Map<String, String>? headers}) async {
    final token = await _getToken();
    final uri = Uri.parse(path);
    final h = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      if (headers != null) ...headers
    };
    return http.post(uri, headers: h, body: jsonEncode(body));
  }

  static Future<http.Response> put(String path, Map body, {Map<String, String>? headers}) async {
    final token = await _getToken();
    final uri = Uri.parse(path);
    final h = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      if (headers != null) ...headers
    };
    return http.put(uri, headers: h, body: jsonEncode(body));
  }
}
