import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/models/chat_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final UserRepository userRepository;
  ChatCubit(this.userRepository) : super(ChatInitial());

  Future<void> sendConversation(List<Map<String, String>> messages) async {
    emit(ChatLoading());

    final result = await userRepository.sendConversation(messages);

    result.fold((failure) => emit(ChatFailure(failure)),
        (summaryResponse) => emit(ChatSuccess(summaryResponse)));
  }
}
