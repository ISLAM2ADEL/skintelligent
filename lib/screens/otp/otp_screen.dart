import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  static final String id = 'OtpScreen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpNumber = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
              // Black background container
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xff474646),
                ),
              ),

              // OTP Form inside a circular ListView
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 70, // Leaves space for the black container
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Container(
                    color: Colors.white, // Background color of the form
                    child: ListView(
                      padding: const EdgeInsets.all(25.0),
                      children: [
                        Image.asset(
                          kotpImagePath,
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                        ),
                        const SizedBox(height: 5),
                        Column(
                          children: [
                            const Text(
                              'Enter the OTP sent to your email:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              context.read<UserCubit>().signInEmail.text,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.purple[300],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        OtpTextField(
                          numberOfFields: 6,
                          fillColor: Colors.black.withValues(alpha: 0.1),
                          filled: true,
                          keyboardType: TextInputType.number,
                          onSubmit: (value) {
                            otpNumber = value;
                            print("The OTP is $value");
                          },
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            if (otpNumber == '123456') {
                              print("The OTP is correct");
                              Navigator.pushReplacementNamed(
                                  context, HomePage.id);
                            } else {
                              print('The OTP is wrong');
                            }
                          },
                          child: const SubmittButton(),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20, // Keeps it 20 pixels above the bottom
                left: 0,
                right: 0, // Ensures it stretches across the screen
                child: Center(
                  // Centers the Row horizontally
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Avoids unnecessary stretching
                    children: [
                      Text(
                        "You have an account?",
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.id);
                          context.read<UserCubit>().signInEmail.clear();
                          context.read<UserCubit>().signInPassword.clear();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )

              // Circular login prompt above the black container
            ],
          ),
        );
      },
    );
  }
}
