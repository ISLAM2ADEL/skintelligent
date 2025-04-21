import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/user_repository.dart';
import '../models/sign_up_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(UserInitial());

  Future<void> signUp(Map<String, dynamic> patientData) async {
    emit(UserLoading());
    try {
      final result = await userRepository.signUp(patientData);
      emit(UserSuccess(result));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}