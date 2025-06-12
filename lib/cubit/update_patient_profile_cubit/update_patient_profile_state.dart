import 'dart:io';

import 'package:skintelligent/models/update_patient_profile_model.dart';

class UpdatePatientProfileState {}

class UpdatePatientProfileInitial extends UpdatePatientProfileState {}

class UpdatePatientProfileLoading extends UpdatePatientProfileState {}

class UpdatePatientProfileSuccess extends UpdatePatientProfileState {
  final UpdatePatientProfileModel updatePatientProfile;

  UpdatePatientProfileSuccess({required this.updatePatientProfile});
}

class UpdatePatientProfileFailure extends UpdatePatientProfileState {
  final String errMessage;

  UpdatePatientProfileFailure({required this.errMessage});
}

final class UpdatePatientProfileImagePicked extends UpdatePatientProfileState {
  final File image;
  UpdatePatientProfileImagePicked(this.image);
}
