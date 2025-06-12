//---------------------- Original code  [donwload image locally and update profile] -----------------------
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:skintelligent/commons.dart';
// import 'package:skintelligent/controllers/repositories/user_repository.dart';
// import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_cubit.dart';
// import 'package:skintelligent/cubit/update_patient_profile_cubit/update_patient_profile_state.dart';

// class UpdatePatientProfileCubit extends Cubit<UpdatePatientProfileState> {
//   final UserRepository userRepository;

//   // Form Controllers
//   final signInEmail = TextEditingController();
//   final signInPassword = TextEditingController();
//   final signUpFirstName = TextEditingController();
//   final signUpLastName = TextEditingController();
//   final signUpPhoneNumber = TextEditingController();
//   final signUpAddress = TextEditingController();
//   final signUpEmail = TextEditingController();
//   final signUpPassword = TextEditingController();
//   final confirmPassword = TextEditingController();
//   final dateOfBirth = TextEditingController();
//   final gender = TextEditingController();

//   File? profilePic;

//   UpdatePatientProfileCubit(this.userRepository)
//       : super(UpdatePatientProfileInitial());

//   // Fetch and fill profile data
//   Future<void> fetchAndFillPatientProfile() async {
//     emit(UpdatePatientProfileLoading());
//     try {
//       int patientId = await getIt<CacheHelper>().getData(key: ApiKey.patientId);
//       final response = await userRepository.getPatientProfile(patientId);
//       final dateFormat = DateFormat('yyyy-MM-dd');

//       response.fold(
//         (err) => emit(UpdatePatientProfileFailure(errMessage: err)),
//         (profile) {
//           signUpFirstName.text = profile.firstName;
//           signUpLastName.text = profile.lastName;
//           signUpPhoneNumber.text = profile.phone;
//           signUpAddress.text = profile.address;
//           dateOfBirth.text = dateFormat.format(profile.dateOfBirth);

//           // Safe image fallback
//           final cachedImageFile = getIt<PatientProfileCubit>().cachedProfilePic;
//           if (profilePic == null && cachedImageFile != null) {
//             profilePic = cachedImageFile;
//           }

//           emit(UpdatePatientProfileInitial());
//         },
//       );
//     } catch (e) {
//       emit(UpdatePatientProfileFailure(errMessage: e.toString()));
//     }
//   }

//   // Pick new image
//   Future<void> pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       profilePic = File(pickedFile.path);
//       emit(UpdatePatientProfileImagePicked(profilePic!));
//     }
//   }

//   // Update the profile
//   Future<void> updatePatientProfile() async {
//     emit(UpdatePatientProfileLoading());

//     int patientId = await getIt<CacheHelper>().getData(key: ApiKey.patientId);

//     if (profilePic == null) {
//       emit(UpdatePatientProfileFailure(
//         errMessage: "Profile picture is required.",
//       ));
//       return;
//     }

//     final response = await userRepository.updatePatientProfile(
//       id: patientId,
//       firstName: signUpFirstName.text,
//       lastName: signUpLastName.text,
//       phone: signUpPhoneNumber.text,
//       address: signUpAddress.text,
//       dateOfBirth: dateOfBirth.text,
//       profilePicture: profilePic!.path,
//     );

//     response.fold(
//       (err) => emit(UpdatePatientProfileFailure(errMessage: err)),
//       (result) =>
//           emit(UpdatePatientProfileSuccess(updatePatientProfile: result)),
//     );
//   }
// }

//------- Updated code [use cache alter download image] -------
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/update_patient_profile_cubit/update_patient_profile_state.dart';

class UpdatePatientProfileCubit extends Cubit<UpdatePatientProfileState> {
  final UserRepository userRepository;

  // Form Controllers
  final signInEmail = TextEditingController();
  final signInPassword = TextEditingController();
  final signUpFirstName = TextEditingController();
  final signUpLastName = TextEditingController();
  final signUpPhoneNumber = TextEditingController();
  final signUpAddress = TextEditingController();
  final signUpEmail = TextEditingController();
  final signUpPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final dateOfBirth = TextEditingController();
  final gender = TextEditingController();

  File? profilePic;
  String? existingProfileImageUrl;

  UpdatePatientProfileCubit(this.userRepository)
      : super(UpdatePatientProfileInitial());

  // Fetch and fill profile data
  Future<void> fetchAndFillPatientProfile() async {
    emit(UpdatePatientProfileLoading());
    try {
      int patientId = await getIt<CacheHelper>().getData(key: ApiKey.patientId);
      final response = await userRepository.getPatientProfile(patientId);
      final dateFormat = DateFormat('yyyy-MM-dd');

      response.fold(
        (err) => emit(UpdatePatientProfileFailure(errMessage: err)),
        (profile) {
          signUpFirstName.text = profile.firstName;
          signUpLastName.text = profile.lastName;
          signUpPhoneNumber.text = profile.phone;
          signUpAddress.text = profile.address;
          dateOfBirth.text = dateFormat.format(profile.dateOfBirth);
          existingProfileImageUrl = profile.profilePicture;

          emit(UpdatePatientProfileInitial());
        },
      );
    } catch (e) {
      emit(UpdatePatientProfileFailure(errMessage: e.toString()));
    }
  }

  // Pick new image
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePic = File(pickedFile.path);
      emit(UpdatePatientProfileImagePicked(profilePic!));
    }
  }

  // Update the profile
  Future<void> updatePatientProfile() async {
    emit(UpdatePatientProfileLoading());

    int patientId = await getIt<CacheHelper>().getData(key: ApiKey.patientId);

    File? imageFileToUpload = profilePic;

    if (imageFileToUpload == null &&
        existingProfileImageUrl != null &&
        existingProfileImageUrl!.isNotEmpty) {
      try {
        imageFileToUpload = await MethodsHelper().downloadAndCacheImage(
          url: existingProfileImageUrl!,
          fileName:
              'profile_image.jpg', // or use basename(existingProfileImageUrl!)
        );
      } catch (e) {
        emit(UpdatePatientProfileFailure(
            errMessage: "Failed to process current image."));
        return;
      }
    }

    final response = await userRepository.updatePatientProfile(
      id: patientId,
      firstName: signUpFirstName.text,
      lastName: signUpLastName.text,
      phone: signUpPhoneNumber.text,
      address: signUpAddress.text,
      dateOfBirth: dateOfBirth.text,
      profilePicture: imageFileToUpload!.path,
    );

    response.fold(
      (err) => emit(UpdatePatientProfileFailure(errMessage: err)),
      (result) =>
          emit(UpdatePatientProfileSuccess(updatePatientProfile: result)),
    );
  }
}
