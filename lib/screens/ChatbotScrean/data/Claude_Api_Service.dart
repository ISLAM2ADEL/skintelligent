import 'dart:convert';
import 'package:http/http.dart' as http;

class ClaudeApiService {
  static const String _baseUrl =
      'http://skintelligent.runasp.net/api/chats/send';

  Future<String> sendMessage({
    required String message,
    required int appointmentId,
    required int patientId,
  }) async {
    final body = jsonEncode({
      'appointmentId': appointmentId,
      'message': message,
      'patinetId': patientId,
    });

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? 'لا يوجد رد من الخادم.';
      } else {
        throw Exception('فشل في الاتصال بالخادم: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال بـ API: $e');
    }
  }
}
