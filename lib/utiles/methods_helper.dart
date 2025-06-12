import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_cubit.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_state.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';

class MethodsHelper {
  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return "Can't be empty";
    } else if (val.length < 6) {
      return "Must be at least 3 characters";
    } else if (!RegExp(r'[A-Z]').hasMatch(val)) {
      return "Must include at least one capital letter";
    } else if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(val)) {
      return "Invalid characters used";
    }
    return null;
  }

  static String? validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return "Email can't be empty";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(val)) {
      return "Enter a valid email";
    }
    return null;
  }

  static void signUpTextFormHelper(BuildContext context) {
    final cubit = context.read<UserCubit>();
    cubit.profilePic = null;
    cubit.signUpFirstName.clear();
    cubit.signUpLastName.clear();
    cubit.signUpPhoneNumber.clear();
    cubit.signUpEmail.clear();
    cubit.signUpPassword.clear();
    cubit.confirmPassword.clear();
    cubit.signUpAddress.clear();
    cubit.profilePic;
    cubit.gender.clear();
    cubit.dateOfBirth.clear();
  }

  static void signInClearTextHelper(BuildContext context) {
    context.read<UserCubit>().signInEmail.clear();
    context.read<UserCubit>().signInPassword.clear();
  }

  String? getPatientProfilePicture(BuildContext context) {
    final state = context.read<PatientProfileCubit>().state;

    if (state is PatientProfileSuccess &&
        state.patientModel.profilePicture.isNotEmpty) {
      return state.patientModel.profilePicture;
    }
    return null; // Fallback to default image if needed
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

  Future clearCachedProfileImage() async {
    final tempDir = await getTemporaryDirectory();
    final cachedFile = File('${tempDir.path}/profile_image.jpg');
    if (await cachedFile.exists()) {
      await cachedFile.delete();
    }
  }
}
