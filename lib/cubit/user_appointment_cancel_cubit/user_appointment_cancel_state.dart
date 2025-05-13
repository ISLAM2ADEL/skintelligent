import 'package:skintelligent/models/user_appointment_cancel_model.dart';

abstract class UserAppointmentCancelState {}

class UserAppointmentCancelInitial extends UserAppointmentCancelState {}

class UserAppointmentCancelLoading extends UserAppointmentCancelState {}

class UserAppointmentCancelSuccess extends UserAppointmentCancelState {
  final UserAppointmentCancelModel cancelModel;
  UserAppointmentCancelSuccess(this.cancelModel);
}

class UserAppointmentCancelFailure extends UserAppointmentCancelState {
  final String message;

  UserAppointmentCancelFailure(this.message);
}
