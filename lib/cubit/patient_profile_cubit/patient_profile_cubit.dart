// import 'package:skintelligent/commons.dart';
// import 'package:skintelligent/controllers/repositories/user_repository.dart';
// import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_state.dart';

// class patientProfileCubit extends Cubit<PatientProfileState> {
//   final UserRepository userRepository;
//   patientProfileCubit(this.userRepository) : super(PatientProfileInitial());

//   Future<void> getPatientProfile({required int userID}) async {
//     emit(PatientProfileLoading());
//     final response = await userRepository.getPatientProfile(userID);

//     response.fold(
//       (err) => emit(PatientProfileFailure(errMessage: err)),
//       (result) => emit(PatientProfileSuccess(patientModel: result)),
//     );
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  final UserRepository userRepository;

  PatientProfileCubit(this.userRepository) : super(PatientProfileInitial());

  Future<void> getPatientProfile() async {
    emit(PatientProfileLoading());
    String token = getIt<CacheHelper>().getData(key: ApiKey.Authorization);
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    int patientId = int.parse(decodedToken['patientId']);

    final response = await userRepository.getPatientProfile(patientId);

    response.fold(
      (err) => emit(PatientProfileFailure(errMessage: err)),
      (result) => emit(PatientProfileSuccess(patientModel: result)),
    );
  }
}
