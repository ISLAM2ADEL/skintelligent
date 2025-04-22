import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:skintelligent/Helpers/KApi.dart';
import 'package:skintelligent/Helpers/dio_helpers.dart';
import 'package:skintelligent/Helpers/hive_helpr.dart';
import 'package:skintelligent/screens/SignUpScreen/Model/RegisterModel.dart';
import 'package:skintelligent/screens/home_screen/home_page.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  // Image Picker Function
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(SignupcubitImagePicked(File(pickedFile.path)));
    }
  }

  // -------------------------------------------------------------------//

  // Register Function (Fix Null Errors)
  void signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
  }) async {
    try {
      emit(Signuploadingstate());

      final response = await DioHelpers.postData(path: KApi.register, body: {
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
      });

      Registermodel signupModel = Registermodel.fromJson(response.data);

      // Fix null error: Ensure status is checked safely
      if (signupModel.status ?? false) {
        // Fix null error: Ensure token is not null
        HiveHelper.setToken(signupModel.data?.token ?? "");

        Get.offAll(() => HomePage()); // Fix navigation call

        emit(SignupSuccessState());
      } else {
        emit(SignupFailureState(signupModel.message ?? "Registration failed"));
      }
    } catch (e) {
      emit(SignupFailureState(e.toString()));
    }
  }
}
