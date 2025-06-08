import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';
import 'package:skintelligent/screens/forget_screen/forget_screen.dart';

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
                    isPassword: true,
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
                            context.read<UserCubit>().signIn().then((value) {
                              MethodsHelper.signInClearTextHelper(context);
                            });
                          },
                          text: "Login",
                        ),
                  const DividerWithText(),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Registerscreen.id),
                      child: const Text('Create new account')),
                  const SizedBox(
                    height: 20,
                  ),
                  const TermsAndPrivacy(),
                  const SizedBox(
                    height: 80,
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
