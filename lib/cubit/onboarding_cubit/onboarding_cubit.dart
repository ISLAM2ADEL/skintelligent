import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
}
