part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class Signuploadingstate extends SignupState {}

final class SignupSuccessState extends SignupState {}

final class SignupFailureState extends SignupState {
  final String error;
  SignupFailureState(this.error);
}

final class SignupcubitImagePicked extends SignupState {
  final File image;
  SignupcubitImagePicked(this.image);
}
