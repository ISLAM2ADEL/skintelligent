import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/onboarding_cubit/onboarding_cubit.dart';
import 'package:skintelligent/cubit/splash_cubit/splash_cubit.dart';
import 'package:skintelligent/screens/splash_and_onboarding/splash_screen.dart';
import 'package:get/get.dart';

import 'authentication/auth_Screens/auth_loginScreen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit(),
        ),
        BlocProvider(
          create: (context) => OnboardingCubit(),
        ),
      ],
      child:  const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
      ),
    );
  }
}
