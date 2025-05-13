part of 'chat_cubit.dart';


abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  final ChatModel chatModel;

  ChatSuccess(this.chatModel);
}

final class ChatFailure extends ChatState {
  final String error;

  ChatFailure(this.error);
}
