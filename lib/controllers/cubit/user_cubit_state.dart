import 'package:skintelligent/commons.dart';

class UserState {}

// inital state
final class UserInitial extends UserState {}

// signin part
final class SigninSuccess extends UserState {
  final String successMessage;

  SigninSuccess({required this.successMessage}); 
}

final class SigninLoading extends UserState {}

final class SigninFailure extends UserState {
  final String errorMessage;
  SigninFailure({required this.errorMessage});
}

// -------------------------------
// Signup part
final class SignupSuccess extends UserState {
  late final String message;
  SignupSuccess({required this.message});
}

final class SignupLoading extends UserState {}

final class SignupFailure extends UserState {
  final String errorMessage;
  SignupFailure({required this.errorMessage});
}

// -------------------------------
// upload profile image  part

final class UploadProfilePic extends UserState {}

// -------------------------------
// get user profile part
final class GetUserProfileSuccess extends UserState {
  late final UserModel user;
  GetUserProfileSuccess({required this.user});
}

final class GetUserProfileLoading extends UserState {}

final class GetUserProfileFailure extends UserState {
  final String errorMessage;
  GetUserProfileFailure({required this.errorMessage});
}
