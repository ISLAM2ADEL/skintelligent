

import 'package:skintelligent/screens/qr_code/qr_code.dart';

import 'commons.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
      child:   GetMaterialApp(
        routes: {
          LoginScreen.id :(context) => const LoginScreen() ,
          Qrcode.id : (context) => const  Qrcode() ,
          ProfileScreen.id : (context) =>  ProfileScreen()
        },
        debugShowCheckedModeBanner: false,
         // home: SplashScreen()
        initialRoute:LoginScreen.id,
      ),
    );
  }
}
