import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skintelligent/const/const.dart';
import 'package:skintelligent/screens/ChatbotScrean/cubit/chatbotcubit_cubit.dart';
import 'package:skintelligent/screens/ChatbotScrean/presentation/chatBubble.dart';
import 'package:skintelligent/screens/ChatbotScrean/presentation/chat_provider.dart';
import 'package:skintelligent/screens/home_screen/home_page.dart';

class Chatbotscreen extends StatelessWidget {
  static const String id = 'Chatbotscreen';
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatProvider(), // From the images you shared
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 217, 237, 253),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, HomePage.id),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text(
            'Doctor Assistant',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Welcome message and image (only shown when no messages exist)
              Consumer<ChatProvider>(
                builder: (context, chatProvider, _) {
                  if (chatProvider.messages.isEmpty) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                              const SizedBox(height: 20),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return Image.asset(
                                    "${path}heart_icon.png",
                                    height: constraints.maxWidth * 0.6,
                                    width: constraints.maxWidth * 0.6,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              // Predefined questions
                              ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  _buildOptionButton(
                                      "Who is susceptible to measles?",
                                      context),
                                  _buildOptionButton(
                                      "Disease prevention after the rainy and flood season",
                                      context),
                                  _buildOptionButton(
                                      "Nutritional treatment for patients with malabsorption?",
                                      context),
                                  _buildOptionButton(
                                      "Update on lipid control guidelines for cardiovascular event prevention?",
                                      context),
                                  _buildOptionButton(
                                      "Which type of pain signals a heart attack?",
                                      context),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              // Chat messages list
              Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, _) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      reverse: false,
                      itemCount: chatProvider.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatProvider.messages[index];
                        return ChatBubble(message: message);
                      },
                    );
                  },
                ),
              ),

              // Image preview (from your existing cubit)
              BlocBuilder<ChatbotcubitCubit, ChatbotcubitState>(
                builder: (context, state) {
                  if (state is ChatbotcubitImagePicked) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        Image.file(
                          state.image,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              // Chat input field
              _buildChatInput(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: () {
          Provider.of<ChatProvider>(context, listen: false).sendMessage(text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildChatInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Ask me anything",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(Icons.chat_bubble_outline),
              ),
              onSubmitted: (text) => _sendMessage(context),
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic),
            color: const Color.fromARGB(255, 56, 55, 55),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () => context.read<ChatbotcubitCubit>().pickImage(),
            icon: const Icon(Icons.image),
            color: const Color.fromARGB(255, 56, 55, 55),
          ),
          IconButton(
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                final chatProvider = context.read<ChatProvider>();
                chatProvider.sendMessage(_messageController.text);
                _messageController.clear();
              }
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      Provider.of<ChatProvider>(context, listen: false).sendMessage(text);
      _messageController.clear();
    }
  }
}
