import 'package:skintelligent/commons.dart';
// ignore: must_be_immutable
class Custombutton extends StatelessWidget {
  Custombutton(
      {this.onTap,
      required this.text,
      this.color,
      this.hight,
      this.textStyle,
      this.imagePath});
  final void Function()? onTap;
  String text;
  Color? color;
  TextStyle? textStyle;
  double? hight;
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        height: hight ,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Color(0xffdcdcdc)  , width: 1.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        if (imagePath != null && imagePath!.isNotEmpty)
          Image.asset(imagePath!, width: 25, height: 25)  ,

      SizedBox(width: 12,) ,
            Text(
              text,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
