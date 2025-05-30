class ChatModel {
  final String response;
  final bool finished;
  final List<FullConversation> fullConversation;

  ChatModel({
    required this.response,
    required this.finished,
    required this.fullConversation,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      response: json['response'] ?? '',
      finished: json['finished'] ?? false,
      fullConversation: (json['full_conversation'] as List<dynamic>? ?? [])
          .map((v) => FullConversation.fromJson(v))
          .toList(),
    );
  }
}

class FullConversation {
  final String role;
  final String content;

  FullConversation({
    required this.role,
    required this.content,
  });

  factory FullConversation.fromJson(Map<String, dynamic> json) {
    return FullConversation(
      role: json['role'] ?? '',
      content: json['content'] ?? '',
    );
  }
}