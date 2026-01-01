import 'package:flutter/material.dart';

class CustomStatusBar extends StatelessWidget {
  final Color? backgroundColor;
  
  const CustomStatusBar({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: backgroundColor ?? const Color(0xFFF5F7FB),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Time (Left)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: Colors.transparent,
              child: const Text(
                '9:30',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),

          // Center Dot / Pill
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),

          // Right Icons
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.signal_cellular_alt,
                    color: Colors.black, size: 18),
                SizedBox(width: 6),
                Icon(Icons.wifi, color: Colors.black, size: 18),
                SizedBox(width: 6),
                Icon(Icons.battery_full,
                    color: Colors.black, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
