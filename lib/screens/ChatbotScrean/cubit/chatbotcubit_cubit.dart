import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'chatbotcubit_state.dart';

class ChatbotcubitCubit extends Cubit<ChatbotcubitState> {
  ChatbotcubitCubit() : super(ChatbotcubitInitial());

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(ChatbotcubitImagePicked(File(pickedFile.path)));
    }
  }
}
