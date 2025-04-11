part of 'forget_cubit.dart';

@immutable
sealed class ForgetState {}

final class ForgetInitial extends ForgetState {}

final class ForgetSuccess extends ForgetState {
  final String successMessage;

  ForgetSuccess({required this.successMessage});
}

final class ForgetLoading extends ForgetState {}

final class ForgetFailure extends ForgetState {
  final String errorMessage;
  ForgetFailure({required this.errorMessage});
}
