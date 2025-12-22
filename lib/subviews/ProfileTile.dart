import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=47"),
      ),
      title: const Text(
        "Rashmita Rasindran",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text("RashmitaRasindran@gmail.com"),
      trailing: const Icon(Icons.chevron_right),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: onTap,
    );
  }
}
