import 'dart:convert';
import 'api_service.dart';
import '../config/constants.dart';
import '../models/order.dart';

class OrderService {
  static Future<Map<String,dynamic>> createOrder(Map payload) async {
    final res = await ApiService.post(API.ORDERS, payload);
    final body = jsonDecode(res.body);
    if (res.statusCode == 201) return {'ok': true, 'order': body};
    return {'ok': false, 'error': body['message'] ?? 'Create order failed'};
  }

  static Future<List<OrderModel>> myOrders() async {
    final res = await ApiService.get('${API.ORDERS}/me');
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List;
      return list.map((e) => OrderModel.fromJson(e)).toList();
    }
    return [];
  }
}
