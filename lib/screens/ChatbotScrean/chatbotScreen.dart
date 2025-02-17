import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skintelligent/const/const.dart';
import 'package:skintelligent/screens/ChatbotScrean/chatbotWidgets.dart';
import 'package:skintelligent/screens/ChatbotScrean/cubit/chatbotcubit_cubit.dart';
import 'package:skintelligent/screens/home_screen/home_page.dart';

class Chatbotscreen extends StatelessWidget {
  static const String id = 'Chatbotscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 237, 253),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomePage.id);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Doctor Assistant',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Text(
                  "Hello, how can I help you today?",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // 🔹 Responsive heart image
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Image.asset(
                      "${path}heart_icon.png",
                      height: constraints.maxWidth * 0.6,
                      width: constraints.maxWidth * 0.6,
                    );
                  },
                ),
                SizedBox(height: 20),

                // 🔹 List of predefined questions
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    buildOptionButton("Who is susceptible to measles?"),
                    buildOptionButton(
                        "Disease prevention after the rainy and flood season"),
                    buildOptionButton(
                        "Nutritional treatment for patients with malabsorption?"),
                    buildOptionButton(
                        "Update on lipid control guidelines for cardiovascular event prevention?"),
                    buildOptionButton(
                        "Which type of pain signals a heart attack?"),
                  ],
                ),

                SizedBox(height: 20),

                BlocBuilder<ChatbotcubitCubit, ChatbotcubitState>(
                  builder: (context, state) {
                    if (state is ChatbotcubitImagePicked) {
                      return Column(
                        children: [
                          SizedBox(height: 20),
                          Image.file(
                            state.image,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),

                // chat input field with image
                _buildChatInput(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Chat input field with image picker
  Widget _buildChatInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Ask me anything",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: Icon(Icons.chat_bubble_outline),
              ),
            ),
          ),
          SizedBox(width: 5),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mic),
            color: const Color.fromARGB(255, 56, 55, 55),
          ),
          SizedBox(width: 5),
          IconButton(
            onPressed: () => context.read<ChatbotcubitCubit>().pickImage(),
            icon: Icon(Icons.image),
            color: const Color.fromARGB(255, 56, 55, 55),
          ),
        ],
      ),
    );
  }
}
