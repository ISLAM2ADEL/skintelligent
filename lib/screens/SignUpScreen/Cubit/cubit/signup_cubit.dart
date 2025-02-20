import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

  // Reister

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
      if (signupModel.status ?? false) {
        HiveHelper.setToken(signupModel.data?.token ?? "");
        Get.offAll((HomePage));
        emit(SignupSuccessState());
      } else {
        emit(SignupFailureState(signupModel.message ?? "Error"));
      }
    } catch (e) {
      emit(SignupFailureState(e.toString()));
    }
  }
}
