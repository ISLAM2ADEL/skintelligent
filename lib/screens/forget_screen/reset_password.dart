import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/forget_cubit/forget_cubit.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key,});
  static const String id = 'ResetPassword';

  @override
  State<ResetPassword> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<ForgetCubit, ForgetState>(
      listener: (context, state) {
        if (state is ForgetResetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage),
            ),
          );
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        } else if (state is ForgetResetFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
              Form(
                key: context.read<ForgetCubit>().forgetFormKey,
                child: Container(
                  color: Colors.white,
                  child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Enter the OTP sent to your email:',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          Image.asset("${path}otp.png", width: width * 0.9),
                          const SizedBox(height: 20),
                          Text(
                              (context.read<ForgetCubit>().resetOTP.text),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.purple[300],
                            ),
                          ),
                      const SizedBox(height: 20),
                      OtpTextField(
                        numberOfFields: 6,
                        fillColor: Colors.black.withOpacity(0.1),
                        filled: true,
                        keyboardType: TextInputType.number,
                        onSubmit: (value) {
                          context.read<ForgetCubit>().resetOTP.text = value;
                        },
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () {
                          if (context.read<ForgetCubit>().forgetFormKey.currentState!.validate()) {
                            Navigator.of(context).push(_createRoute(userEmail: email));
                          }
                        },
                        child: state is ForgetResetLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Container(
                          height: height*.06,
                          width: width*.85,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// -------------------- TRANSITION --------------------
Route _createRoute({
  required String userEmail,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NewPasswordPage(email: userEmail,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// -------------------- NEW PAGE --------------------
class NewPasswordPage extends StatelessWidget {
  final String email; // Store the email as a field

  const NewPasswordPage({super.key, required this.email}); // Assign to field

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Customtextfield(
              myIcon: Icons.mail_outline,
              validate: MethodsHelper.validateEmail,
              MyController: context.read<ForgetCubit>().resetEmail,
              hintM: email, // Now correctly references the field
              isEmail: true,
            ),
            const SizedBox(height: 20),
            Customtextfield(
              myIcon: Icons.lock_open,
              sufIcon: FontAwesomeIcons.eyeSlash,
              validate: MethodsHelper.validatePassword,
              MyController: context.read<ForgetCubit>().resetPassword,
              hintM: "New Password",
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: (){
                if (context
                    .read<ForgetCubit>()
                    .forgetFormKey
                    .currentState!
                    .validate()) {
                  context.read<ForgetCubit>().newPassword();
                }
              },
                child: const SubmittButton()),
          ],
        ),
      ),
    );
  }
}