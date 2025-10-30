class OrderItem {
  final String serviceId;
  final String name;
  final int price;
  final int qty;
  OrderItem({required this.serviceId, required this.name, required this.price, required this.qty});
  factory OrderItem.fromJson(Map<String, dynamic> j) => OrderItem(
    serviceId: j['serviceId']?['_id'] ?? j['serviceId'] ?? '',
    name: j['name'] ?? '',
    price: j['price'] ?? 0,
    qty: j['qty'] ?? 1
  );
}

class OrderModel {
  final String id;
  final String userId;
  final String laundryId;
  final List<OrderItem> items;
  final double total;
  final String status;

  OrderModel({required this.id, required this.userId, required this.laundryId, required this.items, required this.total, required this.status});

  factory OrderModel.fromJson(Map<String, dynamic> j) => OrderModel(
    id: j['_id'] ?? '',
    userId: j['user']?['_id'] ?? j['user'] ?? '',
    laundryId: j['laundry']?['_id'] ?? j['laundry'] ?? '',
    items: (j['items'] as List? ?? []).map((it) => OrderItem.fromJson(it)).toList(),
    total: j['total'] != null ? (j['total'] as num).toDouble() : 0,
    status: j['status'] ?? 'created'
  );
}
