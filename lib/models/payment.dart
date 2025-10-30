class PaymentModel {
  final String id;
  final String orderId;
  final double amount;
  final String gateway;
  final String status;
  PaymentModel({required this.id, required this.orderId, required this.amount, required this.gateway, required this.status});
  factory PaymentModel.fromJson(Map<String, dynamic> j) => PaymentModel(
    id: j['_id'] ?? '',
    orderId: j['order']?['_id'] ?? j['order'] ?? '',
    amount: j['amount'] != null ? (j['amount'] as num).toDouble() : 0,
    gateway: j['gateway'] ?? '',
    status: j['status'] ?? ''
  );
}
