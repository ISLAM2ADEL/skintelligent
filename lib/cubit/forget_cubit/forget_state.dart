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

final class ForgetResetSuccess extends ForgetState {
  final String successMessage;

  ForgetResetSuccess({required this.successMessage});
}

final class ForgetResetLoading extends ForgetState {}

final class ForgetResetFailure extends ForgetState {
  final String errorMessage;
  ForgetResetFailure({required this.errorMessage});
}
