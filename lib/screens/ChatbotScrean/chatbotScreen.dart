// Auto Navigation to home page -------------------
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/chat_cubit/chat_cubit.dart';
import 'package:skintelligent/screens/ChatbotScrean/presentation/chatBubble.dart';
import 'package:skintelligent/screens/home_screen/home_page.dart'; // تأكد من استيراد الصفحة

class Chatbotscreen extends StatefulWidget {
  static const String id = 'Chatbotscreen';
  const Chatbotscreen({super.key});

  @override
  State<Chatbotscreen> createState() => _ChatbotscreenState();
}

class _ChatbotscreenState extends State<Chatbotscreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late int appointmentID;

  bool isBotTyping = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    appointmentID = args['appointmentID'];

    context.read<ChatCubit>().clearConversation();

    isBotTyping = false;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      final messages = [
        {'role': 'user', 'content': text}
      ];
      _messageController.clear();

      // 1. أضف الرسالة فورًا
      context.read<ChatCubit>().addLocalMessage(messages.first);

      // 2. Scroll فورًا علشان نشوف الـ "الروبوت يكتب"
      _scrollToBottom();

      // 3. فعّل حالة الكتابة
      setState(() {
        isBotTyping = true;
      });

      // 4. أرسل للـ API
      context
          .read<ChatCubit>()
          .sendConversation(messages, appointmentID)
          .then((_) {
        setState(() {
          isBotTyping = false;
        });
        _scrollToBottom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xffD4E7EE),
        body: Column(
          children: [
            _buildHeader(),
            BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (state is ChatSuccess && state.finished) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacementNamed(context, HomePage.id);
                  });
                }
              },
              builder: (context, state) {
                final conversation = state is ChatSuccess
                    ? state.fullConversation
                    : context.read<ChatCubit>().conversation;

                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: conversation.length + (isBotTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < conversation.length) {
                        final msg = conversation[index];
                        return ChatBubble(
                          message: msg['content'] ?? '',
                          role: msg['role'] ?? '',
                        );
                      } else {
                        return const ChatBubble(
                          message: "الروبوت يكتب .... ",
                          role: 'assistant',
                        );
                      }
                    },
                  ),
                );
              },
            ),
            _buildChatInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 100,
      color: Colors.white,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 10),
      child: const Text(
        "Doctor Assistant",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              minLines: 1,
              maxLines: 6,
              textDirection: TextDirection.rtl, // ✅ اتجاه الكتابة
              decoration: InputDecoration(
                hintText: "اسألني أي شيء",
                hintTextDirection: TextDirection.rtl, // ✅ اتجاه التلميح كمان
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(Icons.chat_bubble_outline),
              ),
              onSubmitted: (_) => _sendMessage(context),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _sendMessage(context),
          ),
        ],
      ),
    );
  }
}
