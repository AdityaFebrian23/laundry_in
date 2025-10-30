class ServiceItem {
  final String id;
  final String name;
  final String type;
  final int price;
  ServiceItem({required this.id, required this.name, required this.type, required this.price});
  factory ServiceItem.fromJson(Map<String, dynamic> j) => ServiceItem(
    id: j['_id'] ?? '',
    name: j['name'] ?? '',
    type: j['type'] ?? 'per_kg',
    price: j['price'] ?? 0
  );
}

class LaundryModel {
  final String id;
  final String name;
  final String description;
  final Map<String, dynamic>? address;
  final double? rating;
  final List<ServiceItem> services;
  final String ownerId;

  LaundryModel({
    required this.id, required this.name, required this.description,
    this.address, this.rating, required this.services, required this.ownerId
  });

  factory LaundryModel.fromJson(Map<String, dynamic> j) {
    return LaundryModel(
      id: j['_id'] ?? '',
      name: j['name'] ?? '',
      description: j['description'] ?? '',
      address: j['address'],
      rating: j['rating'] != null ? (j['rating'] as num).toDouble() : null,
      ownerId: j['owner']?['_id'] ?? j['owner'] ?? '',
      services: (j['services'] as List? ?? []).map((s) => ServiceItem.fromJson(s)).toList()
    );
  }
}
