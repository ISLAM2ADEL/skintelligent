import 'package:skintelligent/commons.dart';

// ignore: must_be_immutable
class Customtextfield extends StatelessWidget {
  Customtextfield(
      {required this.hintM,
      required this.MyController,
      required this.validate,
      required this.myIcon,
      this.sufIcon});
  // Attributes
  TextEditingController MyController;
  String? hintM;
  IconData myIcon;
  IconData? sufIcon;
  String? Function(String?)? validate;
  //---------------------------------------------
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: MyController,
      validator: validate,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)  ,
        ),
          prefixIcon: Icon(myIcon , color: Colors.grey,),
          hintText: hintM,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }
}
