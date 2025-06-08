import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '../../controllers/cache/cache_helper.dart';
import '../../screens/splash_and_onboarding/animation_welcome_screen.dart';
import '../../services/service_locator.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  bool isOnBoarding=false;

  void navigateAfterDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(const AnimationWelcomeScreen());
      getIt<CacheHelper>()
          .saveData(key: "isOnboarding", value: isOnBoarding);
    });
  }
}
