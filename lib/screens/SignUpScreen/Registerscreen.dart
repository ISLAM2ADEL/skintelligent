import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skintelligent/screens/ChatbotScrean/cubit/chatbotcubit_cubit.dart';
import 'package:skintelligent/screens/SignUpScreen/Cubit/cubit/signup_cubit.dart';
import 'package:skintelligent/screens/SignUpScreen/RegisterWidgets.dart';

class Registerscreen extends StatelessWidget {
  static const String id = 'Registerscreen';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SignupFailureState) {
          Get.snackbar(
            "Error",
            state.error,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF6D9BA6),
        appBar: AppBar(
          backgroundColor: Color(0xFF6D9BA6),
          title: Text("Register Information",
              style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          buildInputField(
                            Icons.person,
                            "Full name *",
                            "Walaa",
                            controller: _nameController,
                          ),
                          buildInputField(Icons.public, "Country", "Egypt",
                              controller: _addressController),
                          // buildInputField(Icons.calendar_today, "Date of birth",
                          //     "01/10/2003"),
                          buildInputField(
                            Icons.phone,
                            "Phone *",
                            "+201063519131",
                            controller: _phoneController,
                          ),
                          buildInputField(
                              Icons.email, "Email", "Walaa@example.com",
                              controller: _emailController),
                          buildInputField(Icons.password, "Password", "W1259w",
                              controller: _passwordController),
                          // buildInputField(Icons.male, "Gender", "Male"),
                          SizedBox(height: 10),
                          //------------------------------------------------------
                          // Register Button
                          Container(
                            width: double.infinity,
                            child: BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    context.read<SignupCubit>().signUp(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          name: _nameController.text,
                                          phone: _phoneController.text,
                                          address: _addressController
                                              .text, // Add the required address parameter
                                        );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF6D9BA6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                  ),
                                  child: Text("Register",
                                      style: TextStyle(color: Colors.white)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // BlocBuilder<ChatbotcubitCubit, ChatbotcubitState>(
                    //   builder: (context, state) {
                    //     return GestureDetector(
                    //       onTap: () =>
                    //           context.read<ChatbotcubitCubit>().pickImage(),
                    //       child: CircleAvatar(
                    //         radius: 55,
                    //         backgroundColor: Colors.white,
                    //         backgroundImage: state is ChatbotcubitImagePicked
                    //             ? FileImage(state.image) as ImageProvider
                    //             : null,
                    //         child: state is! ChatbotcubitImagePicked
                    //             ? Icon(Icons.person,
                    //                 size: 50, color: Colors.grey)
                    //             : null,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
