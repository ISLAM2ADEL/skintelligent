import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';
import 'package:skintelligent/custom_form_button.dart';
import 'package:skintelligent/custom_input_field.dart';
import 'package:skintelligent/pick_image_widget.dart';

class Registerscreen extends StatelessWidget {
  static const String id = 'Registerscreen';
  GlobalKey<FormState> signUpFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF6D9BA6),
          appBar: AppBar(
            backgroundColor: const Color(0xFF6D9BA6),
            title: const Text("Register Information",
                style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: signUpFormKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              CustomInputField(
                                labelText: 'Name',
                                hintText: 'Your name',
                                isDense: true,
                                controller:
                                    context.read<UserCubit>().signUpName,
                              ),
                              const SizedBox(height: 16),
                              //!Email
                              CustomInputField(
                                labelText: 'Email',
                                hintText: 'Your email',
                                isDense: true,
                                controller:
                                    context.read<UserCubit>().signUpEmail,
                              ),
                              const SizedBox(height: 16),
                              //! Phone Number
                              CustomInputField(
                                labelText: 'Phone number',
                                hintText: 'Your phone number ex:01234567890',
                                isDense: true,
                                controller:
                                    context.read<UserCubit>().signUpPhoneNumber,
                              ),
                              const SizedBox(height: 16),
                              //! Password
                              CustomInputField(
                                labelText: 'Password',
                                hintText: 'Your password',
                                isDense: true,
                                obscureText: true,
                                suffixIcon: true,
                                controller:
                                    context.read<UserCubit>().signUpPassword,
                              ),
                              CustomInputField(
                                labelText: 'Confirm Password',
                                hintText: 'Confirm Your password',
                                isDense: true,
                                obscureText: true,
                                suffixIcon: true,
                                controller:
                                    context.read<UserCubit>().confirmPassword,
                              ),

                              const SizedBox(height: 10),
                              state is SignUpLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : CustomFormButton(
                                      innerText: 'Signup',
                                      onPressed: () {
                                        context
                                            .read<UserCubit>()
                                            .signUp()
                                            .then((value) {
                                          MethodsHelper.signUpTextFormHelper(
                                              context);
                                        });
                                      },
                                    ),
                            ],
                          ),
                        ),
                        //                    const PickImageWidget(),
                        const PickImageWidget(),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
