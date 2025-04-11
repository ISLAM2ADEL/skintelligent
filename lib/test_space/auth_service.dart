import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://skintelligent.runasp.net", // Replace with actual API URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
  );

  /// **Login Method**
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "/api/auth/login",
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        await _saveToken(data['token']); // Save token securely
        return data;
      } else {
        return {"error": "Invalid credentials"};
      }
    } on DioException catch (e) {
      return {"error": e.response?.data['message'] ?? "Network Error"};
    }
  }

  /// **Save Token in SharedPreferences**
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  /// **Get Stored Token**
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// **Logout: Clear Token**
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
