import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';
import '../../controllers/cache/cache_helper.dart';
import '../../screens/login_and_register/login.dart';
import '../../services/service_locator.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  final PageController pageController = PageController();

  int pageNum = 1;
  String getPage() {
    return pageNum.toString();
  }

  void nextPage() {
    pageNum++;
    emit(OnboardingNext());
  }

  void updatePage(int newPage) {
    pageNum = newPage;
    emit(OnboardingUpdate());
  }

  void previousPage() {
    pageNum--;
    emit(OnboardingPrevious());
  }

  void loginPage() {
    getIt<CacheHelper>()
        .saveData(key: "isOnboarding", value: true);
    Get.off(const LoginScreen());
  }
}
