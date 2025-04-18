import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';
import 'package:skintelligent/screens/forget_screen/forget_screen.dart';
import 'package:skintelligent/screens/otp/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  // Attributes

  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> signInFormKey = GlobalKey();

//------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('success'),
            ),
          );
          Navigator.pushNamed(context, HomePage.id);
        } else if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Form(
            key: signInFormKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  const LanguagesDropDown(),
                  Image.asset(
                    kSkintelligenPath,
                    height: 172,
                    width: 310,
                  ),
                  Customtextfield(
                    myIcon: Icons.mail_outline,
                    validate: MethodsHelper.validateEmail,
                    MyController: context.read<UserCubit>().signInEmail,
                    hintM: "Enter your email",
                  ),
                  const SizedBox(height: 20),
                  Customtextfield(
                    myIcon: Icons.lock_open,
                    sufIcon: FontAwesomeIcons.eyeSlash,
                    validate: MethodsHelper.validatePassword,
                    MyController: context.read<UserCubit>().signInPassword,
                    hintM: "Password",
                  ),
                  Customtextbutton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      ForgetScreen.id,
                    ),
                    text: "Forget Password?",
                    position: MainAxisAlignment.end,
                  ),
                  const SizedBox(height: 20),
                  state is SignInLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Custombutton(
                          hight: 70,
                          textStyle: const TextStyle(
                              color: kMyPrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          color: kMySecondaryColor,
                          onTap: () {
                            // if (context
                            //     .read<UserCubit>()
                            //     .signInFormKey
                            //     .currentState!
                            //     .validate()) {
                            // }
                            context.read<UserCubit>().signIn().then((value) {
                              MethodsHelper.signInTextFormHelper(context);
                            });
                          },
                          text: "Login",
                        ),
                  const DividerWithText(),
                  Custombutton(
                    imagePath: kGoogleImagePath,
                    hight: 70,
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, LoginScreen.id),
                    text: "Sign in with google",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Custombutton(
                    imagePath: kFacebookImagePath,
                    hight: 70,
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, LoginScreen.id),
                    text: "Sign in with facebook",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Registerscreen.id),
                      child: const Text('Create new account')),
                  const SizedBox(
                    height: 20,
                  ),
                  const TermsAndPrivacy(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Version 1.4.1",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
