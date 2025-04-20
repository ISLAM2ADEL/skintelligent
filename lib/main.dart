import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:skintelligent/controllers/api/dio_consumer.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_cubit.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';
import 'package:skintelligent/screens/forget_screen/forget_screen.dart';
import 'package:skintelligent/screens/forget_screen/reset_password.dart';
import 'package:skintelligent/screens/otp/otp_screen.dart';
import 'package:skintelligent/screens/user_booking/user_booking.dart';
import 'package:skintelligent/test_space/appoinment.dart';
import 'package:skintelligent/test_space/login_screen.dart';
import 'package:skintelligent/cubit/forget_cubit/forget_cubit.dart';
import 'commons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setputServiceLocator();
  await getIt<CacheHelper>().init();

  runApp(
    MyApp(),
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
          create: (context) => AppointmentCubit(UserRepository(api: DioConsumer(dio: Dio()))),
        ),
        BlocProvider(
          create: (context) => ChatbotcubitCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ForgetCubit(UserRepository(api: DioConsumer(dio: Dio()))),
        ),
        BlocProvider(
          create: (context) =>
              UserCubit(UserRepository(api: DioConsumer(dio: Dio()))),
        ),
        BlocProvider(
          create: (context) => DoctorCubit(
            UserRepository(api: DioConsumer(dio: Dio())),
          ),
        ),
        BlocProvider(
          create: (context) => AvailableBookingCubit(
            UserRepository(api: DioConsumer(dio: Dio())),
          ),
        ),
      ],
      child: GetMaterialApp(
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          Qrcode.id: (context) => const Qrcode(),
          ProfileScreen.id: (context) => ProfileScreen(),
          UserBookingScreen.id: (context) => const UserBookingScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          HomePage.id: (context) => const HomePage(),
          Appointment.id: (context) => const Appointment(),
          Chatbotscreen.id: (context) => Chatbotscreen(),
          Registerscreen.id: (context) => Registerscreen(),
          OtpScreen.id: (context) => const OtpScreen(),
          LoginScreenTest.id: (context) => LoginScreenTest(),
          AppointmentScreen.id: (context) => const AppointmentScreen(),
          ResetPassword.id: (context) => const ResetPassword(),
          ForgetScreen.id:(context)=>const ForgetScreen()
        },
        debugShowCheckedModeBanner: false,
        // home: SplashScreen()
        initialRoute: LoginScreen.id,
      ),
    );
  }
}

