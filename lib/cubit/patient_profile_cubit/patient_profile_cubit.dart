
//-----------Without download the image and cache it -----------
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  final UserRepository userRepository;

  PatientProfileCubit(this.userRepository) : super(PatientProfileInitial());

  Future<void> getPatientProfile() async {
    emit(PatientProfileLoading());

    try {
      final token = getIt<CacheHelper>().getData(key: ApiKey.Authorization);
      final decodedToken = JwtDecoder.decode(token);

      await getIt<CacheHelper>().saveData(
        key: ApiKey.patientId,
        value: int.parse(decodedToken['patientId']),
      );

      final patientId =
          await getIt<CacheHelper>().getData(key: ApiKey.patientId);
      final response = await userRepository.getPatientProfile(patientId);

      response.fold(
        (err) {
          emit(PatientProfileFailure(errMessage: err));
        },
        (result) {
          emit(PatientProfileSuccess(patientModel: result));
        },
      );
    } catch (e) {
      emit(PatientProfileFailure(errMessage: e.toString()));
    }
  }
}
