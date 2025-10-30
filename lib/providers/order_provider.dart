import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> orders = [];

  Future<void> loadMyOrders() async {
    orders = await OrderService.myOrders();
    notifyListeners();
  }

  Future<bool> createOrder(Map payload) async {
    final res = await OrderService.createOrder(payload);
    if (res['ok']) {
      await loadMyOrders();
      return true;
    }
    return false;
  }
}
