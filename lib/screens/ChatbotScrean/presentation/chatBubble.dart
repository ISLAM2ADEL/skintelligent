import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final dynamic message;
  final dynamic role;

  const ChatBubble({
    super.key,
    required this.message,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    bool isUser = false;
    String content = '';

    try {
      if (message is String) {
        isUser = role == 'user';
        content = message;
      } else if (message is Map) {
        isUser = message['role'] == 'user';
        content = message['content'] ?? '';
      } else {
        isUser = message.role == 'user';
        content = message.content ?? '';
      }
    } catch (e) {
      content = 'حدث خطأ في عرض الرسالة';
      isUser = false;
    }

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          content,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
