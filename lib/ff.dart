import 'package:flutter/material.dart';
import 'package:skintelligent/screens/Screens_loginScreen.dart';

void main() {
  runApp( SkintelligenApp());
}
class SkintelligenApp extends StatelessWidget {
  const SkintelligenApp({super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id : (context) => LoginScreen()
      },
      initialRoute:LoginScreen.id,

    );
  }
}
