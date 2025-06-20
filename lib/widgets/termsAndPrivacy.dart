import 'package:skintelligent/commons.dart';

class TermsAndPrivacy extends StatelessWidget {
  const TermsAndPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Centers the entire content
      child: Container(
        alignment: Alignment.center, // Ensures text is centered
        child: Text.rich(
          TextSpan(
            text: 'By tapping login, you agree to our ',
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B6C70)),
            children: <TextSpan>[
              TextSpan(
                text: 'Conditions of use Privacy policy',
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.blue), // Use your `kMySecondaryColor`
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              const TextSpan(
                text: " ours",
                style: TextStyle(fontSize: 13, color: Color(0xFF6B6C70)),
              )
            ],
          ),
          textAlign: TextAlign.center, // Centers text inside Text widget
        ),
      ),
    );
  }
}
