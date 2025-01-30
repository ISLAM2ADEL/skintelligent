import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '../../screens/splash_and_onboarding/animation_welcome_screen.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void navigateAfterDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(const AnimationWelcomeScreen());
    });
  }
}
