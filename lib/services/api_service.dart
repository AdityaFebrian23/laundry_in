import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class ApiService {
  // 🔹 Pastikan ganti IP dengan IP komputer kamu (bukan localhost)
  // Android emulator → gunakan 10.0.2.2
  // Web/Chrome → gunakan localhost
  static const String baseUrl = "http://10.61.24.179:5000/api/auth"; 

  final Dio _dio = Dio();

  // 🔹 LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "$baseUrl/login",
        data: {"email": email, "password": password},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;

        // Pastikan response punya field yang dibutuhkan
        if (data['token'] != null && data['role'] != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', data['token']);
          await prefs.setString('role', data['role']);
          await prefs.setString('email', data['email'] ?? '');

          return {
            "success": true,
            "role": data['role'],
            "email": data['email'],
          };
        } else {
          return {"success": false, "message": "Format respons tidak valid"};
        }
      } else {
        return {"success": false, "message": "Login gagal, kode: ${response.statusCode}"};
      }
    } on DioException catch (e) {
      // Tangani error dari server atau jaringan
      if (e.response != null) {
        return {"success": false, "message": e.response?.data['message'] ?? 'Login gagal'};
      }
      return {"success": false, "message": "Gagal konek ke server: ${e.message}"};
    } catch (e) {
      return {"success": false, "message": "Error: ${e.toString()}"};
    }
  }

  // 🔹 GET PROFILE
  Future<UserModel?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    try {
      final response = await _dio.get(
        "$baseUrl/me",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserModel.fromJson(response.data['user']);
      }
    } catch (e) {
      print("Gagal ambil profil: $e");
    }
    return null;
  }

  // 🔹 LOGOUT
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
