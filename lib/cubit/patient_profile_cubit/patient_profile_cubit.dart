// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:skintelligent/commons.dart';
// import 'package:skintelligent/controllers/repositories/user_repository.dart';
// import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_state.dart';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';

// class PatientProfileCubit extends Cubit<PatientProfileState> {
//   final UserRepository userRepository;

//   File? cachedProfilePic;

//   PatientProfileCubit(this.userRepository) : super(PatientProfileInitial());

//   Future<void> getPatientProfile() async {
//     emit(PatientProfileLoading());

//     String token = getIt<CacheHelper>().getData(key: ApiKey.Authorization);
//     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

//     await getIt<CacheHelper>().saveData(
//       key: ApiKey.patientId,
//       value: int.parse(decodedToken['patientId']),
//     );

//     int patientId = await getIt<CacheHelper>().getData(key: ApiKey.patientId);
//     final response = await userRepository.getPatientProfile(patientId);

//     response.fold(
//       (err) => emit(PatientProfileFailure(errMessage: err)),
//       (result) async {
//         if (result.profilePicture.isNotEmpty) {
//           try {
//             cachedProfilePic = await downloadImage(result.profilePicture);
//           } catch (e) {
//             print("❗ Failed to download profile picture: $e");
//           }
//         }

//         emit(PatientProfileSuccess(patientModel: result));
//       },
//     );
//   }

//   Future<File> downloadImage(String url) async {
//     final tempDir = await getTemporaryDirectory();
//     final filePath = '${tempDir.path}/${basename(url)}';
//     final file = File(filePath);
//     await Dio().download(url, filePath);
//     return file;
//   }
// }
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_state.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  final UserRepository userRepository;

  File? cachedProfilePic;

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

      await response.fold(
        (err) async {
          emit(PatientProfileFailure(errMessage: err));
        },
        (result) async {
          if (result.profilePicture.isNotEmpty) {
            try {
              // Delete old image if exists
              if (cachedProfilePic != null &&
                  await cachedProfilePic!.exists()) {
                await cachedProfilePic!.delete();
              }

              // Download and assign new image
              cachedProfilePic = await downloadAndCacheImage(
                url: result.profilePicture,
                fileName: 'cached_profile_pic.jpg',
              );
            } catch (e) {
              print("❗ Failed to download or replace profile picture: $e");
            }
          }

          emit(PatientProfileSuccess(patientModel: result));
        },
      );
    } catch (e) {
      emit(PatientProfileFailure(errMessage: e.toString()));
    }
  }

  Future<File> downloadAndCacheImage({
    required String url,
    required String fileName,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$fileName';

    final file = File(filePath);
    await Dio().download(url, filePath);

    return file;
  }
}
