import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:skintelligent/controllers/api/dio_consumer.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_cubit.dart';
import 'package:skintelligent/cubit/chat_cubit/chat_cubit.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:skintelligent/cubit/get_review_cubti/review_cubit.dart';
import 'package:skintelligent/cubit/make_booking_cubit/make_booking_cubit.dart';
import 'package:skintelligent/cubit/make_review_cubit/make_review_cubit.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_cubit.dart';
import 'package:skintelligent/cubit/summary_cubit/summary_cubit.dart';
import 'package:skintelligent/cubit/user_appointment_cancel_cubit/user_appointment_cancel_cubit.dart';
import 'package:skintelligent/cubit/user_booking_cubit/user_booking_cubit.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';
import 'package:skintelligent/screens/forget_screen/forget_screen.dart';
import 'package:skintelligent/screens/forget_screen/reset_password.dart';
import 'package:skintelligent/screens/otp/otp_screen.dart';
import 'package:skintelligent/screens/patient_profile/patient_profile_screen.dart';
import 'package:skintelligent/screens/summary_screen/summary_screen.dart';
import 'package:skintelligent/screens/user_booking_screen/user_booking_screen.dart';
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
    UserRepository userRepository =
        UserRepository(api: DioConsumer(dio: Dio()));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit(),
        ),
        BlocProvider(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider(
          create: (context) => AppointmentCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => ChatbotcubitCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => ForgetCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => UserCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => DoctorCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => AvailableBookingCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => GetReviewCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => MakeReviewCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => MakeBookingCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => UserBookingCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => UserAppointmentCancelCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => SummaryCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => ChatCubit(userRepository),
        ),
        BlocProvider(
          create: (context) => PatientProfileCubit(userRepository),
        ),
      ],
      child: GetMaterialApp(
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          UserBookingScreen.id: (context) => const UserBookingScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          HomePage.id: (context) => const HomePage(),
          Appointment.id: (context) => const Appointment(),
          Chatbotscreen.id: (context) => Chatbotscreen(),
          Registerscreen.id: (context) => Registerscreen(),
          OtpScreen.id: (context) => OtpScreen(),
          ResetPassword.id: (context) => const ResetPassword(),
          ForgetScreen.id: (context) => const ForgetScreen(),
          SummaryScreen.id: (context) => const SummaryScreen(),
          PatientProfileScreen.id: (context) => const PatientProfileScreen(),
        },
        debugShowCheckedModeBanner: false,
        // home: SplashScreen()
        initialRoute:
            getIt<CacheHelper>().getData(key: ApiKey.Authorization) != null
                ? HomePage.id
                : (getIt<CacheHelper>().getData(key: "isOnboarding") ?? false)
                    ? LoginScreen.id
                    : SplashScreen.id,
      ),
    );
  }
}
