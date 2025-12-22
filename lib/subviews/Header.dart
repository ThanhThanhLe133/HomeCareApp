import 'package:flutter/material.dart';

import '../ChatBotScreen.dart';
import '../NotificationScreen.dart';

class Header extends StatelessWidget {
  const Header({super.key, this.onNotificationTap, this.onChatTap});

  final VoidCallback? onNotificationTap;
  final VoidCallback? onChatTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "My Home",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const Icon(Icons.keyboard_arrow_down),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.smart_toy_outlined, color: Color(0xFF4A6CF7)),
          onPressed: onChatTap ?? () => _openChat(context),
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined),
              onPressed: onNotificationTap ?? () => _openNotifications(context),
            ),
            const Positioned(
              right: 8,
              top: 8,
              child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  void _openChat(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ChatBotScreen()));
  }

  void _openNotifications(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const NotificationScreen()));
  }
}
