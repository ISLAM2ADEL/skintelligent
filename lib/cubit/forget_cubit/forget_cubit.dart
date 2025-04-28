import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skintelligent/models/forget_model.dart';

import '../../commons.dart';
import '../../controllers/repositories/user_repository.dart';
import '../../models/reset_model.dart';

part 'forget_state.dart';

class ForgetCubit extends Cubit<ForgetState> {
  ForgetCubit(this.userRepository) : super(ForgetInitial());
  final UserRepository userRepository;

  GlobalKey<FormState> forgetFormKey = GlobalKey();
  TextEditingController forgetEmail = TextEditingController();
  ForgetModel? forget;
  GlobalKey<FormState> resetFormKey = GlobalKey();
  TextEditingController resetEmail = TextEditingController();
  TextEditingController resetPassword = TextEditingController();
  TextEditingController resetOTP = TextEditingController();

  ResetModel? reset;

  forgetPassword() async {
    emit(ForgetLoading());
    final response = await userRepository.forgetPassword(
      email: forgetEmail.text,
    );
    response.fold(
      (errMessage) => emit(ForgetFailure(errorMessage: errMessage)),
      (ForgetModel) => emit(ForgetSuccess(successMessage: ForgetModel.message)),
    );
  }
  String getEmail(){
    return forgetEmail.text;
  }
  newPassword() async {
    emit(ForgetResetLoading());
    final response = await userRepository.resetPassword(
      email: forgetEmail.text,
      password: resetPassword.text,
      resetOTP: resetOTP.text,
    );
    response.fold(
      (errMessage) => emit(ForgetResetFailure(errorMessage: errMessage)),
      (ResetModel) =>
          emit(ForgetResetSuccess(successMessage: ResetModel.message)),
    );
  }
}
