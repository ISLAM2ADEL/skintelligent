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
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
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
                  EdgeInsets.symmetric(horizontal: width*.05, vertical: height*.02),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          padding:  EdgeInsets.symmetric(
                              vertical: height*.065, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              CustomInputField(
                                labelText: 'First Name',
                                hintText: 'EX : Ahmed',
                                isDense: true,
                                controller:
                                    context.read<UserCubit>().signUpFirstName,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                labelText: 'Last Name',
                                hintText: 'EX : Mohammed',
                                isDense: true,
                                controller:
                                context.read<UserCubit>().signUpLastName,
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
                                hintText: 'ex:01234567890',
                                isDense: true,
                                controller:
                                    context.read<UserCubit>().signUpPhoneNumber,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                labelText: 'Address',
                                hintText: 'Dokki, Giza',
                                isDense: true,
                                controller:
                                context.read<UserCubit>().signUpAddress,
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
                              const SizedBox(height: 16),
                              CustomInputField(
                                labelText: 'Confirm Password',
                                hintText: 'Confirm Your password',
                                isDense: true,
                                obscureText: true,
                                suffixIcon: true,
                                controller:
                                    context.read<UserCubit>().confirmPassword,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                labelText: 'Date of Birth',
                                hintText: 'Your date of birth',
                                isDense: true,
                                controller:
                                    context.read<UserCubit>().dateOfBirth,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                labelText: 'Gender',
                                hintText: 'Your gender',
                                isDense: true,
                                controller: context.read<UserCubit>().gender,
                              ),
                              const SizedBox(height: 10),
                              state is SignUpLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : CustomFormButton(
                                      innerText: 'Signup',
                                      onPressed: () {
                                        // context
                                        //     .read<UserCubit>()
                                        //     .signUp()
                                        //     .then((value) {
                                        //   MethodsHelper.signUpTextFormHelper(
                                        //       context);
                                        // });
                                        context.read<UserCubit>().signUp().then((value) {
                                          MethodsHelper.signUpTextFormHelper(context);
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
