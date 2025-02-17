import 'package:skintelligent/cubit/appointment_cubit/appointment_cubit.dart';
import 'package:skintelligent/screens/ChatbotScrean/chatbotScreen.dart';
import 'package:skintelligent/screens/ChatbotScrean/cubit/chatbotcubit_cubit.dart';
import 'package:skintelligent/screens/SignUpScreen/Cubit/cubit/signup_cubit.dart';
import 'package:skintelligent/screens/SignUpScreen/Registerscreen.dart';
import 'package:skintelligent/screens/appointment/appointment.dart';
import 'package:skintelligent/screens/home_screen/home_page.dart';
import 'package:skintelligent/screens/qr_code/qr_code.dart';

import 'commons.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(MyApp());
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
        },
        debugShowCheckedModeBanner: false,
        // home: SplashScreen()
        initialRoute: SplashScreen.id,
      ),
    );
  }
}
