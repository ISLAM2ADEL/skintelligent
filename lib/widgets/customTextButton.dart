import 'package:skintelligent/commons.dart';

class Customtextbutton extends StatelessWidget {
  Customtextbutton(
      {super.key,
      required this.position,
      required this.text,
      required this.onPressed});

  String text;
  dynamic onPressed;
  MainAxisAlignment position;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: position,
      children: [
        TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(color: kMySecondaryColor),
            )),
      ],
    );
  }
}
