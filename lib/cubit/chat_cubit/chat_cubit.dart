import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final UserRepository userRepository;
  List<Map<String, String>> _conversation = [];

  ChatCubit(this.userRepository) : super(ChatInitial());

  void addLocalMessage(Map<String, String> message) {
    _conversation.add(message);
    emit(ChatSuccess(List.from(_conversation)));
  }

  List<Map<String, String>> get conversation => _conversation;

  Future<void> sendConversation(
    List<Map<String, String>> messages,
    int appointmentID,
  ) async {
    final userMessage = messages.first;
    emit(ChatLoading());

    final result =
        await userRepository.sendConversation(messages, appointmentID);

    result.fold(
      (failure) => emit(ChatFailure(failure)),
      (chatModel) {
        _conversation.add({
          'role': 'assistant',
          'content': chatModel.response,
        });

        emit(ChatSuccess(List.from(_conversation),
            finished: chatModel.finished));
      },
    );
  }

  void clearConversation() {
    _conversation.clear();
    emit(ChatInitial());
  }
}
