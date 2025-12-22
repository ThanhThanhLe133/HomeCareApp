import 'package:flutter/material.dart';

import 'model/ChatMessage.dart';
import 'subviews/InputBar.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      "Hello, I’m Bobo! I help to make your house better :)",
      Sender.bot,
    ),
    ChatMessage(
      "I just set up my Homcare+ account. What cool things can I do with it?",
      Sender.user,
    ),
    ChatMessage(
      "Awesome! With HomeCare, you can control devices, set up automation, manage energy, and more! What are you interested in exploring first?",
      Sender.bot,
    ),
    ChatMessage("What’s my house name?", Sender.user),
    ChatMessage(
      "You currently manage 3 houses: My House, My Girlfriend House, My Parent House. What house do you want me to show the details?",
      Sender.bot,
    ),
    ChatMessage("How many bulks do I have in My House?", Sender.user),
    ChatMessage(
      "You have 3 Bulks in your house. In Bathroom, Bedroom and Garden.",
      Sender.bot,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend(String text) {
    setState(() {
      _messages.add(ChatMessage(text, Sender.user));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _ChatHeader(onBack: () => Navigator.of(context).maybePop()),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _ChatBubble(message: _messages[i]),
              ),
            ),
            InputBar(controller: _controller, onSend: _handleSend),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFEFF2FF),
            child: Icon(Icons.smart_toy_outlined, color: Color(0xFF4A6CF7)),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bobo Assistant',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  'Online · Ready to help',
                  style: TextStyle(color: Color(0xFF6B6B6B)),
                ),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.sender == Sender.user;
    final Color background = isUser
        ? const Color(0xFF4A6CF7)
        : const Color(0xFFF2F3F7);
    final Color textColor = isUser ? Colors.white : const Color(0xFF1F1F1F);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 6),
            bottomRight: Radius.circular(isUser ? 6 : 18),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: textColor, fontSize: 15, height: 1.4),
        ),
      ),
    );
  }
}
