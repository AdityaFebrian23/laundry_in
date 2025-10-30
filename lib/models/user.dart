class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? phone;
  final double? wallet;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.wallet,
  });

  /// 🔹 Convert dari JSON (misalnya dari API atau SharedPreferences)
  factory UserModel.fromJson(Map<String, dynamic> j) {
    return UserModel(
      id: j['_id']?.toString() ?? j['id']?.toString() ?? '',
      name: j['name'] ?? '',
      email: j['email'] ?? '',
      role: j['role'] ?? 'user',
      phone: j['phone']?.toString(),
      wallet: j['wallet'] != null
          ? double.tryParse(j['wallet'].toString())
          : null,
    );
  }

  /// 🔹 Convert ke JSON (untuk disimpan di SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'wallet': wallet,
    };
  }
}
