import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Import the package
import 'package:get/get.dart';
import 'package:skintelligent/screens/splash_and_onboarding/onboarding.dart';

class AnimationWelcomeScreen extends StatelessWidget {
  const AnimationWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: width * .9,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Skintelligent',
                  textStyle: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 50,
                  ),
                ),
                TyperAnimatedText(
                  'Your Health, One Scan Away!',
                  textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              onFinished: () {
                // Navigate to another screen after the animation ends
                Get.off(const Onboarding());
              },
              isRepeatingAnimation:
                  false, // Ensure the animation runs only once
            ),
          ),
        ),
      ),
    );
  }
}
