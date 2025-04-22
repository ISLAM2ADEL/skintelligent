part of 'appointment_cubit.dart';

@immutable
sealed class AppointmentState {}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentDateUpdate extends AppointmentState {}

final class AppointmentTimeUpdate extends AppointmentState {}
