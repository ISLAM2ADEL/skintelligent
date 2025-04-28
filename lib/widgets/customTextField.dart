import 'package:skintelligent/commons.dart';

// ignore: must_be_immutable
class Customtextfield extends StatelessWidget {
  Customtextfield(
      {required this.hintM,
      required this.MyController,
      @required this.validate,
      required this.myIcon,
      this.isEmail =false,
      this.sufIcon});
  // Attributes
  TextEditingController MyController;
  String? hintM;
  IconData myIcon;
  IconData? sufIcon;
  bool isEmail;
  String? Function(String?)? validate;
  //---------------------------------------------
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isEmail ?true:false,
      controller: MyController,
      validator: validate,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(
            myIcon,
            color: Colors.grey,
          ),
          hintText: hintM,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }
}
