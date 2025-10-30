class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? phone;
  final double? wallet;

  UserModel({required this.id, required this.name, required this.email, required this.role, this.phone, this.wallet});

  factory UserModel.fromJson(Map<String, dynamic> j) {
    return UserModel(
      id: j['_id'] ?? j['id'] ?? '',
      name: j['name'] ?? '',
      email: j['email'] ?? '',
      role: j['role'] ?? 'user',
      phone: j['phone'],
      wallet: j['wallet'] != null ? (j['wallet'] as num).toDouble() : null,
    );
  }
}
