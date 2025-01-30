import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';
import 'package:skintelligent/authentication/auth_Screens/auth_loginScreen.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  int pageNum = 1;
  String getPage() {
    return pageNum.toString();
  }

  void nextPage() {
    pageNum++;
    emit(OnboardingNext());
  }

  void previousPage() {
    pageNum--;
    emit(OnboardingPrevious());
  }
  void loginPage() {
    Get.off(const LoginScreen());
  }
}
