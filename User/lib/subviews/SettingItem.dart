import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool enabled;
  final bool isDanger;
  final VoidCallback? onTap;

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    this.enabled = true,
    this.isDanger = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDanger
        ? Colors.red
        : enabled
        ? Colors.black
        : Colors.grey;

    return ListTile(
      leading: Icon(icon, size: 26, color: color),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: color),
      ),
      trailing: const Icon(Icons.chevron_right),
      enabled: enabled,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: enabled ? onTap : null,
    );
  }
}
