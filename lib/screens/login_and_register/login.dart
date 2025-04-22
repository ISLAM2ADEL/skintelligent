import 'package:skintelligent/commons.dart';
import 'package:skintelligent/screens/home_screen/home_page.dart';
import 'package:skintelligent/utiles/dio_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  // Attributes

  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey();

//---------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Form(
        key: formState,
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
                MyController: email,
                hintM: "Enter your email",
              ),
              const SizedBox(height: 20),
              Customtextfield(
                myIcon: Icons.lock_open,
                sufIcon: FontAwesomeIcons.eyeSlash,
                validate: ConstantsMethods.validatePassword,
                MyController: password,
                hintM: "Password",
              ),
              Customtextbutton(
                text: "Forget Password?",
                position: MainAxisAlignment.end,
              ),
              const SizedBox(height: 20),
              Custombutton(
                hight: 70,
                textStyle: const TextStyle(
                    color: kMyPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                color: kMySecondaryColor,
                onTap: () {
                  if (formState.currentState!.validate()) {
                    Navigator.pushReplacementNamed(context, HomePage.id);
                  }
                },
                text: "Login",
              ),
              DividerWithText(),
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
  }
}
