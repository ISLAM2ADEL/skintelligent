import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/screens/ChatbotScrean/cubit/chatbotcubit_cubit.dart';
import 'package:skintelligent/screens/SignUpScreen/RegisterWidgets.dart';

class Registerscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6D9BA6),
      appBar: AppBar(
        backgroundColor: Color(0xFF6D9BA6),
        title:
            Text("Register Information", style: TextStyle(color: Colors.white)),
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
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        buildInputField(Icons.person, "Full name *", "Walaa"),
                        buildInputField(Icons.public, "Country", "Egypt"),
                        buildInputField(Icons.calendar_today, "Date of birth",
                            "01/10/2003"),
                        buildInputField(
                            Icons.phone, "Phone *", "+201063519131"),
                        buildInputField(
                            Icons.email, "Email", "Walaa@example.com"),
                        buildInputField(Icons.male, "Gender", "Male"),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6D9BA6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text("Register",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ChatbotcubitCubit, ChatbotcubitState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () =>
                            context.read<ChatbotcubitCubit>().pickImage(),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          backgroundImage: state is ChatbotcubitImagePicked
                              ? FileImage(state.image) as ImageProvider
                              : null,
                          child: state is! ChatbotcubitImagePicked
                              ? Icon(Icons.person, size: 50, color: Colors.grey)
                              : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
