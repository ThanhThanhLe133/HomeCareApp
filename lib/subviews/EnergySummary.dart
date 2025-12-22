import 'package:flutter/material.dart';

class EnergySummary extends StatelessWidget {
  const EnergySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          _EnergyCard(
            title: "This month",
            value: "629.05",
            price: "\$101.4",
            icon: Icons.flash_on,
            iconColor: Colors.orange,
          ),
          SizedBox(width: 12),
          _EnergyCard(
            title: "Previous month",
            value: "703.79",
            price: "\$120.4",
            icon: Icons.bolt,
            iconColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class _EnergyCard extends StatelessWidget {
  final String title;
  final String value;
  final String price;
  final IconData icon;
  final Color iconColor;

  const _EnergyCard({
    required this.title,
    required this.value,
    required this.price,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 6),
            Text(
              "$value kWh",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(price, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
