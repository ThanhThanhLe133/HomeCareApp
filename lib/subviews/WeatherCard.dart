import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A73E8), Color(0xFF2EC7FF)],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "20°C",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "New York City, USA",
                style: TextStyle(color: Colors.white70),
              ),
              Text("Today Cloudy", style: TextStyle(color: Colors.white70)),
            ],
          ),
          const Spacer(),
          Icon(Icons.cloud, size: 80, color: Colors.white70),
        ],
      ),
    );
  }
}
