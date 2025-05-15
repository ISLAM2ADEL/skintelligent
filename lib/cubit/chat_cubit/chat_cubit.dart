import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/models/chat_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final UserRepository userRepository;
  ChatCubit(this.userRepository) : super(ChatInitial());

  Future<void> sendConversation(List<Map<String, String>> messages) async {
    print("ChatCubit called with: $messages");
    emit(ChatLoading());

    final result = await userRepository.sendConversation(messages);

    result.fold(
      (failure) {
        print("❌ API Error: $failure");
        emit(ChatFailure(failure));
      },
      (chatModel) {
        print("✅ API Success:");
        print("Response: ${chatModel.response}");
        print("Finished: ${chatModel.finished}");
        for (var convo in chatModel.fullConversation) {
          print("→ ${convo.role}: ${convo.content}");
        }
        emit(ChatSuccess(chatModel));
      },
    );
  }
}
