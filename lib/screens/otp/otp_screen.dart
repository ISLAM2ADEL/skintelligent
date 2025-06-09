import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';

class OtpScreen extends StatefulWidget {
  final String? email;

  OtpScreen({super.key, this.email});

  static final String id = 'OtpScreen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpNumber = '';

  @override
  void initState() {
    super.initState();
    print('Email passed from Registerscreen: ${widget.email}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xff474646),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 70,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      padding: const EdgeInsets.all(25.0),
                      children: [
                        Image.asset(
                          kotpImagePath,
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                        ),
                        const SizedBox(height: 5),
                        const Column(
                          children: [
                            Text(
                              'Enter the OTP sent to your email:',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        OtpTextField(
                          numberOfFields: 6,
                          fillColor: Colors.black.withAlpha(25),
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
                            if (otpNumber.isNotEmpty) {
                              context.read<UserCubit>().newUser(
                                email: widget.email!,
                                otpCode: otpNumber,
                              );
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.id);
                            } else {
                              print("OTP or Email is empty");
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
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "You have an account?",
                        style: TextStyle(
                            color: Colors.white.withAlpha(130)),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
