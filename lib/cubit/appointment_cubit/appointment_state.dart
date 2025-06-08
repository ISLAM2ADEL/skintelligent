part of 'appointment_cubit.dart';

@immutable
sealed class AppointmentState {}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentDateUpdate extends AppointmentState {}

final class AppointmentTimeUpdate extends AppointmentState {}

final class AppointmentLoading extends AppointmentState {}

final class AppointmentFailure extends AppointmentState {
  final String errorMessage;
  AppointmentFailure({required this.errorMessage});
}

final class AppointmentSuccess extends AppointmentState {
  final String successMessage;
  final List<DoctorModel> doctors;
  final int count;

  AppointmentSuccess({
    required this.successMessage,
    required this.doctors,
    required this.count,
  });
}
final class AppointmentSortLoading extends AppointmentState {}

final class AppointmentSortFailure extends AppointmentState {
  final String errorMessage;
  AppointmentSortFailure({required this.errorMessage});
}

final class AppointmentSortSuccess extends AppointmentState {
  final String successMessage;
  final List<DoctorModel> doctors;
  final int count;

  AppointmentSortSuccess({
    required this.successMessage,
    required this.doctors,
    required this.count,
  });
}
