import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository) : super(UserInitial());

  String newEmail = '';
  bool isObstruct = true;
  final UserRepository userRepository;
  //Sign in Form key
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  //Profile Pic
  File? profilePic;
  //Sign up name
  TextEditingController signUpFirstName = TextEditingController();
  TextEditingController signUpLastName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  TextEditingController signUpAddress = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController gender = TextEditingController();
  SigninModel? user;

  void uploadProfilePic(File pic) {
    profilePic = pic; // Store the selected image
    emit(UploadProfilePic(profilePic: pic));
  }

  Future<void> signUp() async {
    emit(SignUpLoading());

    if (profilePic == null) {
      emit(SignUpFailure(errMessage: "Please upload a profile picture."));
      return;
    }

    try {
      // طباعة جميع البيانات قبل الإرسال
      print('SignUp Data:');
      print('First Name: ${signUpFirstName.text}');
      print('Last Name: ${signUpLastName.text}');
      print('Address: ${signUpAddress.text}');
      print('Phone: ${signUpPhoneNumber.text}');
      print('Email: ${signUpEmail.text}');
      print('Password: ${signUpPassword.text}');
      print('Date of Birth: ${dateOfBirth.text}');
      print('Gender: ${gender.text}');
      print('Confirm Password: ${confirmPassword.text}');
      print('Profile Picture Path: ${profilePic!.path}');
      newEmail=signUpEmail.text;
      await userRepository.signUp(
        firstName: signUpFirstName.text,
        lastName: signUpLastName.text,
        address: signUpAddress.text,
        phone: signUpPhoneNumber.text,
        email: signUpEmail.text,
        password: signUpPassword.text,
        dateOfBirth: dateOfBirth.text,
        gender: gender.text,
        confirmPassword: confirmPassword.text,
        imagePath: profilePic!.path,
      );

      emit(SignUpSuccess(message: "Signup Successful"));
    } catch (e) {
      print('Error during signup: $e');
      emit(SignUpFailure(errMessage: e.toString()));
    }
  }

  signIn() async {
    emit(SignInLoading());
    final response = await userRepository.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );
    response.fold(
          (errMessage) => emit(SignInFailure(errMessage: errMessage)),
          (signInModel) => emit(SignInSuccess(message: signInModel.message)),
    );
  }

  getUserProfile() async {
    emit(GetUserLoading());
    final response = await userRepository.getUserProfile();
    response.fold(
          (errMessage) => emit(GetUserFailure(errMessage: errMessage)),
          (user) => emit(GetUserSuccess(user: user)),
    );
  }
  void changeState(){
    isObstruct=!isObstruct;
    emit(ChangeState());
  }

  Future<void> newUser({required String email, required String otpCode}) async {
    try {
      emit(NewUserLoading());
      final response = await userRepository.newUser(
        email: email,
        otpCode: otpCode,
      );

      response.fold(
            (errMessage) => emit(NewUserFailure(errMessage: errMessage)),
            (confirmModel) => emit(NewUserSuccess(user: confirmModel.message)),
      );
    } catch (e) {
      emit(NewUserFailure(errMessage: 'Something went wrong: $e'));
    }
  }

}