
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
      finished: json['finished'] == 'true' || json['finished'] == true,
      fullConversation: (json['full_conversation'] as List<dynamic>? ?? [])
          .map((v) => FullConversation.fromJson(v))
          .toList(),
    );
  }

  ChatModel copyWith({
    String? response,
    bool? finished,
    List<FullConversation>? fullConversation,
  }) {
    return ChatModel(
      response: response ?? this.response,
      finished: finished ?? this.finished,
      fullConversation: fullConversation ?? this.fullConversation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'finished': finished,
      'full_conversation': fullConversation.map((e) => e.toJson()).toList(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
