part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<Map<String, String>> fullConversation;
  final bool finished;

  ChatSuccess(this.fullConversation, {this.finished = false});
}

class ChatFailure extends ChatState {
  final String error;

  ChatFailure(this.error);
}
