import 'dart:io';

import '../../models/user_model.dart'; // Make sure to import dart:io for File

class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {
  final String message;

  SignInSuccess({required this.message});
}

final class UploadProfilePic extends UserState {
  final File? profilePic;  // Use File? instead of dynamic

  UploadProfilePic({required this.profilePic});
}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

final class SignUpSuccess extends UserState {
  final String message;

  SignUpSuccess({required this.message});
}

final class SignUpLoading extends UserState {}

final class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}

final class GetUserSuccess extends UserState {
  final UserModel user;

  GetUserSuccess({required this.user});
}

final class GetUserLoading extends UserState {}

final class GetUserFailure extends UserState {
  final String errMessage;

  GetUserFailure({required this.errMessage});
}
