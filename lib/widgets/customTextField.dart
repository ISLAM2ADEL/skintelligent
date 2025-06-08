import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';

// ignore: must_be_immutable
class Customtextfield extends StatelessWidget {
  Customtextfield({
    required this.hintM,
    required this.MyController,
    @required this.validate,
    required this.myIcon,
    this.isEmail = false,
    this.isPassword = false,
    this.sufIcon
  });

  // Attributes
  TextEditingController MyController;
  String? hintM;
  IconData myIcon;
  IconData? sufIcon;
  bool isEmail;
  bool isPassword;
  String? Function(String?)? validate;

  //---------------------------------------------
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final cubit = context.read<UserCubit>();
        bool isObstruct = cubit.isObstruct;
        return TextFormField(
          obscureText: isPassword&&isObstruct,
          keyboardType: isEmail ? TextInputType.emailAddress : TextInputType
              .text,
          readOnly: isEmail ? true : false,
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
              suffixIcon: isPassword
                  ? IconButton(
                  icon: Icon(
                    isObstruct
                        ? Icons.remove_red_eye
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    cubit.changeState();
                  } // function to toggle isObstruct
              )
                  : null,
              hintText: hintM,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey)),
        );
      },
    );
  }
}
