import 'package:flutter/material.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/forget_cubit/forget_cubit.dart';
import 'package:skintelligent/screens/forget_screen/reset_password.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});
  static const String id = 'ForgetScreen';
  @override
  Widget build(BuildContext context) {
    final cubit=context.read<ForgetCubit>();
    return BlocConsumer<ForgetCubit, ForgetState>(
      listener: (context, state) {
        if (state is ForgetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage),
            ),
          );
          Navigator.pushReplacementNamed(
            context,
            ResetPassword.id,
            arguments: cubit.getEmail(), // Pass the collected email
          );
        } else if (state is ForgetFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Form(
            key: context.read<ForgetCubit>().forgetFormKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  const SizedBox(height: 45),
                  Image.asset(
                    kSkintelligenPath,
                    height: 172,
                    width: 310,
                  ),
                  Customtextfield(
                    myIcon: Icons.mail_outline,
                    validate: MethodsHelper.validateEmail,
                    MyController: context.read<ForgetCubit>().forgetEmail,
                    hintM: "Enter your email to reset password",
                  ),
                  const SizedBox(height: 20),
                  state is ForgetLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Custombutton(
                          hight: 70,
                          textStyle: const TextStyle(
                              color: kMyPrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          color: kMySecondaryColor,
                          onTap: () {
                            if (context
                                .read<ForgetCubit>()
                                .forgetFormKey
                                .currentState!
                                .validate()) {
                              context.read<ForgetCubit>().forgetPassword();
                            }
                          },
                          text: "Reset Password",
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
