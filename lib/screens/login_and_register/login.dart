import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/cubit/user_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  // Attributes

  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//---------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage),
            ),
          );
          Navigator.pushReplacementNamed(context, HomePage.id);
        } else if (state is SigninFailure) {
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
            key: context.read<UserCubit>().signInFormKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  const LanguagesDropDown(),
                  const SizedBox(height: 45),
                  Image.asset(
                    kSkintelligenPath,
                    height: 172,
                    width: 310,
                  ),
                  Customtextfield(
                    myIcon: Icons.mail_outline,
                    validate: ConstantsMethods.validateEmail,
                    MyController: context.read<UserCubit>().signInEmail,
                    hintM: "Enter your email",
                  ),
                  const SizedBox(height: 20),
                  Customtextfield(
                    myIcon: Icons.lock_open,
                    sufIcon: FontAwesomeIcons.eyeSlash,
                    validate: ConstantsMethods.validatePassword,
                    MyController: context.read<UserCubit>().signInPassword,
                    hintM: "Password",
                  ),
                  Customtextbutton(
                    text: "Forget Password?",
                    position: MainAxisAlignment.end,
                  ),
                  const SizedBox(height: 20),
                  state is SigninLoading
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
                            context.read<UserCubit>().signin();
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
                    height: 125,
                  ),
                  TermsAndPrivacy(),
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
