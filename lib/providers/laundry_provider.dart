import 'package:flutter/material.dart';
import '../models/laundry.dart';
import '../services/api_service.dart';
import '../config/constants.dart';
import 'dart:convert';

class LaundryProvider extends ChangeNotifier {
  List<LaundryModel> laundries = [];

  Future<void> fetchLaundries({String? city}) async {
    final res = await ApiService.get(API.LAUNDRIES, query: city != null ? {'city': city} : null);
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List;
      laundries = list.map((e) => LaundryModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
