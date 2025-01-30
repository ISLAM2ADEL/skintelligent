import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants_Colors/Constants_color.dart';

class TermsAndPrivacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // Centers the entire content
        child: Container(
          alignment: Alignment.center, // Ensures text is centered
          child: Text.rich(
            TextSpan(
              text: 'By tapping login, you agree to our ',
              style: TextStyle(fontSize: 13, color: Color(0xFF6B6C70)),
              children: <TextSpan>[
                TextSpan(
                  text: 'Conditions of use Privacy policy',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue), // Use your `kMySecondaryColor`
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text: " ours",
                  style: TextStyle(fontSize: 13, color: Color(0xFF6B6C70)),
                )
              ],
            ),
            textAlign: TextAlign.center, // Centers text inside Text widget
          ),
        ),
      ),
    );
  }
}
