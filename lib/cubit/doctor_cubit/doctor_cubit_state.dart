// lib/cubit/doctor_cubit/doctor_cubit_state.dart

import 'package:skintelligent/models/doctor_model.dart';

class DoctorState {}

class DoctorInitial extends DoctorState {}

class GetDoctorLoading extends DoctorState {}

class GetDoctorSuccess extends DoctorState {
  final DoctorModel doctor;

  GetDoctorSuccess({required this.doctor});
}

class GetDoctorFailure extends DoctorState {
  final String errMessage;

  GetDoctorFailure({required this.errMessage});
}
