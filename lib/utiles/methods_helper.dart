import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<UserCubit>().signUpName.clear();
    context.read<UserCubit>().signUpPhoneNumber.clear();
    context.read<UserCubit>().profilePic = null;
    context.read<UserCubit>().signUpEmail.clear();
    context.read<UserCubit>().signInPassword.clear();
    context.read<UserCubit>().signUpPassword.clear();
    context.read<UserCubit>().confirmPassword.clear();
  }

  static void signInTextFormHelper(BuildContext context) {
    context.read<UserCubit>().signInEmail.clear();
    context.read<UserCubit>().signInPassword.clear();
  }
}
