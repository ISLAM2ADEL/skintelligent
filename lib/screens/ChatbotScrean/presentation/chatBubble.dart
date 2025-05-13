import 'package:flutter/material.dart';
import 'package:skintelligent/models/chat_model.dart';

class ChatBubble extends StatelessWidget {
  final FullConversation message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    bool isUser = message.role == 'user';
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isUser ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message.content,
        style: TextStyle(
          color: isUser ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
