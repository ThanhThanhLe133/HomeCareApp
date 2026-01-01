import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        title: const Text('Notification', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildHeader("New", showMarkAsRead: true),
          _buildNotificationItem("Add Booking", "Amit Pandey", "02 min ago", isNew: true),
          _buildNotificationItem("Cancel Booking", "Stan Dupp", "25 min ago", isNew: true),
          
          // Background shading for some items as seen in image
          Container(
            color: Colors.grey[50],
            child: Column(
              children: [
                _buildNotificationItem("Add Booking", "Anna Domino", "30 min ago", isNew: true),
                _buildNotificationItem("Cancel Booking", "Albert Watson", "25 min ago", isNew: true),
              ],
            ),
          ),
          
          _buildHeader("Earlier", showMarkAsRead: false),
          _buildNotificationItem("Add Booking", "Mustafa Leek", "1 day", isNew: false),
          _buildNotificationItem("Cancel Booking", "Mary Krismass", "2 day", isNew: false),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, {required bool showMarkAsRead}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          if (showMarkAsRead)
            TextButton(
              onPressed: () {},
              child: const Text("Mark as all read", style: TextStyle(color: Color(0xFF405FF2))),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String name, String time, {required bool isNew}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/image7.png',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    children: [
                      const TextSpan(text: "New Booking Added by "),
                      TextSpan(text: name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
