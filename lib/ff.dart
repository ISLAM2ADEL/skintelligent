import 'package:flutter/material.dart';

import 'authentication/auth_Screens/auth_loginScreen.dart';

void main() {
  runApp( const SkintelligenApp());
}
class SkintelligenApp extends StatelessWidget {
  const SkintelligenApp({super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id : (context) => const LoginScreen()
      },
      initialRoute:LoginScreen.id,

    );
  }
}
