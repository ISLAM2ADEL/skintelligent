// lib/providers/chat_provider.dart
import 'package:flutter/material.dart';
import 'package:skintelligent/screens/ChatbotScrean/Model/message.dart';

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String content) async {
    // Add user message
    _messages.add(Message(
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    _isLoading = true;
    notifyListeners();

    try {
      // Here you would call your actual API (Claude or your backend)
      // For now, we'll simulate a response
      await Future.delayed(const Duration(seconds: 1));
      
      _messages.add(Message(
        content: "This is a simulated response to: $content",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      _messages.add(Message(
        content: "Error: $e",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}