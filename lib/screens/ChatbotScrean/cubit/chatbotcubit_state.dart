part of 'chatbotcubit_cubit.dart';

@immutable
sealed class ChatbotcubitState {}

final class ChatbotcubitInitial extends ChatbotcubitState {}
class ChatbotcubitImagePicked extends ChatbotcubitState {
  final File image;
  ChatbotcubitImagePicked(this.image);
}