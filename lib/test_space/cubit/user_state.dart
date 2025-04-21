part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserSuccess extends UserState {
  final SignUpModel model;
  UserSuccess(this.model);
}
class UserFailure extends UserState {
  final String error;
  UserFailure(this.error);
}