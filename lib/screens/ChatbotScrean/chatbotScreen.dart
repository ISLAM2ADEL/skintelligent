import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skintelligent/cubit/chat_cubit/chat_cubit.dart';
import 'package:skintelligent/screens/ChatbotScrean/presentation/chatBubble.dart';
import 'package:skintelligent/screens/home_screen/home_page.dart';

class Chatbotscreen extends StatelessWidget {
  static const String id = 'Chatbotscreen';
  final TextEditingController _messageController = TextEditingController();

  Chatbotscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD4E7EE),
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
            // Chat header
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffD4E7EE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'How Can I Help You Today?',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // BlocListener for showing error snackbar
            BlocListener<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ChatSuccess) {
                      final chatModel = state.chatModel;
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: chatModel.fullConversation.length,
                        itemBuilder: (context, index) {
                          final message = chatModel.fullConversation[index];
                          return ChatBubble(message: message, role: null);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),

            // Chat input field
            _buildChatInput(context),
          ],
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
            onPressed: () => _sendMessage(context),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      final messages = [
        {"role": "user", "content": text}
      ];
      context.read<ChatCubit>().sendConversation(messages);
      _messageController.clear();
    }
  }
}