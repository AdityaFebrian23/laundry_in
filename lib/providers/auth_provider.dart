import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;
  String? token;

  bool get isAuthenticated => user != null;

  /// 🔹 Muat user & token dari SharedPreferences saat startup (Splash)
  Future<void> loadFromStorage() async {
    final sp = await SharedPreferences.getInstance();
    final userString = sp.getString('user');
    final tokenString = sp.getString('token');
    if (userString != null) {
      user = UserModel.fromJson(jsonDecode(userString));
    }
    if (tokenString != null) {
      token = tokenString;
    }
    notifyListeners();
  }

  /// 🔹 Simpan data user + token setelah login
  Future<void> setUserFromMap(Map<String, dynamic> map) async {
    user = UserModel.fromJson(map['user'] ?? map);
    token = map['token'];

    final sp = await SharedPreferences.getInstance();
    await sp.setString('user', jsonEncode(user!.toJson()));
    if (token != null) await sp.setString('token', token!);

    notifyListeners();
  }

  /// 🔹 Logout user: hapus data lokal dan arahkan ke login
  Future<void> logout(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('user');
    await sp.remove('token');
    user = null;
    token = null;
    notifyListeners();

    // arahkan ke halaman login
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
