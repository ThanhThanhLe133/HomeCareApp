import 'package:flutter/material.dart';
import 'EditProfileScreen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        title: const Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Image with Edit Icon
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: const AssetImage('assets/images/image1.png'),
                    onBackgroundImageError: (exception, stackTrace) {},
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: const Color(0xFF405FF2),
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ashutosh Pandey',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'ashutosh@provider.com',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),
            
            // Menu Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.grid_view, "My Service"),
                    _buildMenuItem(Icons.people_outline, "Houseman"),
                    _buildMenuItem(Icons.location_on_outlined, "Service Address"),
                    _buildMenuItem(Icons.verified_outlined, "Taxes"),
                    _buildMenuItem(Icons.history, "Earning List"),
                    _buildMenuItem(Icons.wb_sunny_outlined, "App Theme", hasArrow: false),
                    _buildMenuItem(Icons.language, "App Language"),
                    _buildMenuItem(Icons.lock_outline, "Change Password"),
                    _buildMenuItem(Icons.info_outline, "About", isLast: true),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Logout",
                style: const TextStyle(color: Color(0xFF405FF2), fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool hasArrow = true, bool isLast = false}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black54, size: 22),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
          trailing: hasArrow 
            ? const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey) 
            : null,
          onTap: () {},
        ),
        if (!isLast)
          Divider(height: 1, indent: 20, endIndent: 20, color: Colors.grey[200]),
      ],
    );
  }
}
