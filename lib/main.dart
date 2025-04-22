import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/Helpers/dio_helpers.dart';
import 'package:skintelligent/Helpers/hive_helpr.dart';
import 'package:skintelligent/cubit/appointment_cubit/appointment_cubit.dart';
import 'package:skintelligent/screens/ChatbotScrean/chatbotScreen.dart';
import 'package:skintelligent/screens/ChatbotScrean/cubit/chatbotcubit_cubit.dart';
import 'package:skintelligent/screens/ChatbotScrean/presentation/chat_provider.dart';
import 'package:skintelligent/screens/SignUpScreen/Cubit/cubit/signup_cubit.dart';
import 'package:skintelligent/screens/SignUpScreen/Registerscreen.dart';
import 'package:skintelligent/screens/appointment/appointment.dart';
import 'package:skintelligent/screens/home_screen/home_page.dart';
import 'package:skintelligent/screens/qr_code/qr_code.dart';
import 'package:skintelligent/commons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.token);

  // Initialize Dio
  DioHelpers.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        // Your other providers...
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          create: (context) => AppointmentCubit(),
        ),
        BlocProvider(
          create: (context) => ChatbotcubitCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
      ],
      child: GetMaterialApp(
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          Qrcode.id: (context) => const Qrcode(),
          ProfileScreen.id: (context) => ProfileScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          HomePage.id: (context) => const HomePage(),
          Appointment.id: (context) => const Appointment(),
          Chatbotscreen.id: (context) => Chatbotscreen(),
          Registerscreen.id: (context) => Registerscreen(),
          // Added from image (if needed)
          // '/chat': (context) => const ChatPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: Chatbotscreen.id,
      ),
    );
  }
}
