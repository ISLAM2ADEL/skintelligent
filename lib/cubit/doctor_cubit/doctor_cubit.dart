// lib/cubit/doctor_cubit/doctor_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit_state.dart';
import 'package:skintelligent/models/doctor_model.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit(this.userRepository) : super(DoctorInitial());

  final UserRepository userRepository;

  DoctorModel? doctor;

  Future<void> getDoctorProfile() async {
    emit(GetDoctorLoading());

    final response = await userRepository.getDoctorProfile(); // assuming this exists

    response.fold(
      (err) => emit(GetDoctorFailure(errMessage: err)),
      (result) {
        doctor = result;
        emit(GetDoctorSuccess(doctor: result));
      },
    );
  }
}
