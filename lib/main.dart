import 'package:dio/dio.dart';
import 'package:skintelligent/controllers/api/dio_consumer.dart';
import 'package:skintelligent/controllers/cubit/user_cubit.dart';

import 'commons.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setputServiceLocator();
  await getIt<CacheHelper>().init();

  runApp(
    BlocProvider(
      create: (context) => UserCubit(DioConsumer(dio: Dio())),
      child: MyApp(),
    ),
  );
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
