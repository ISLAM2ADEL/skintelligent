import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/onboarding_cubit/onboarding_cubit.dart';
import 'package:skintelligent/cubit/splash_cubit/splash_cubit.dart';
import 'package:skintelligent/screens/ChatbotScrean/chatbotScreen.dart';
import 'package:skintelligent/screens/ChatbotScrean/cubit/chatbotcubit_cubit.dart';
import 'package:skintelligent/screens/SignUpScreen/Cubit/cubit/signup_cubit.dart';
import 'package:skintelligent/screens/SignUpScreen/Registerscreen.dart';
import 'package:skintelligent/screens/splash_and_onboarding/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        BlocProvider(
          create: (context) => ChatbotcubitCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false, home: Registerscreen()),
    );
  }
}
