import 'package:flutter/material.dart';
import 'package:skintelligent/screens/ChatbotScrean/Model/message.dart';
import 'package:skintelligent/screens/ChatbotScrean/data/Claude_Api_Service.dart';

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  final ClaudeApiService _apiService = ClaudeApiService();

  Future<void> sendMessage(String content) async {
    _messages.add(Message(
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    _isLoading = true;
    notifyListeners();

    try {
      // استدعاء API الحقيقية مع المعلمات المطلوبة
      final response = await _apiService.sendMessage(
        message: content,
        appointmentId: 1032, // استخدم القيم المناسبة
        patientId: 9,
      );

      _messages.add(Message(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      _messages.add(Message(
        content: "حدث خطأ أثناء إرسال الرسالة: $e",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
