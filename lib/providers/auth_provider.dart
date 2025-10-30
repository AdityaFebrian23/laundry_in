import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;
  bool get isAuthenticated => user != null;

  Future<void> loadFromStorage() async {
    final sp = await SharedPreferences.getInstance();
    final s = sp.getString('user');
    if (s != null) user = UserModel.fromJson(jsonDecode(s));
    notifyListeners();
  }

  Future<void> setUserFromMap(Map<String,dynamic> map) async {
    user = UserModel.fromJson(map);
    final sp = await SharedPreferences.getInstance();
    await sp.setString('user', jsonEncode(map));
    notifyListeners();
  }

  Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('user');
    await sp.remove('token');
    user = null;
    notifyListeners();
  }
}
