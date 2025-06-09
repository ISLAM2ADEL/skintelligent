import 'package:skintelligent/models/patient_profile_model.dart';

class PatientProfileState {}

class PatientProfileInitial extends PatientProfileState {}

class PatientProfileLoading extends PatientProfileState {}

class PatientProfileSuccess extends PatientProfileState {
  final PatientProfileModel patientModel;

  PatientProfileSuccess({required this.patientModel});
}

class PatientProfileFailure extends PatientProfileState {
  final String errMessage;

  PatientProfileFailure({required this.errMessage});
}
