import 'package:flutter/material.dart';

class AutomationCard extends StatefulWidget {
  const AutomationCard({
    super.key,
    required this.title,
    required this.taskCount,
    required this.icons,
    required this.enabled,
    this.onTap,
  });

  final String title;
  final int taskCount;
  final List<IconData> icons;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  State<AutomationCard> createState() => _AutomationCardState();
}

class _AutomationCardState extends State<AutomationCard> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.enabled;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.taskCount} Task${widget.taskCount > 1 ? 's' : ''}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                ..._buildIcons(),
                const Spacer(),
                Switch(
                  value: isOn,
                  activeThumbColor: const Color(0xFF4A6CF7),
                  onChanged: (value) => setState(() => isOn = value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIcons() {
    return widget.icons
        .map(
          (icon) => Container(
            margin: const EdgeInsets.only(right: 8),
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF3FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF4A6CF7)),
          ),
        )
        .toList();
  }
}
