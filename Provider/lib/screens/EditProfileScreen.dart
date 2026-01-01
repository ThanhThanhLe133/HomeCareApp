import 'package:flutter/material.dart';
import '../widgets/CustomStatusBar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: const CustomStatusBar(),
        ),
        Expanded(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Profile Image with Camera Icon
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundImage: const AssetImage('assets/images/image1.png'),
                          onBackgroundImageError: (exception, stackTrace) {},
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF405FF2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt_outlined, size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Form Fields
                  _buildTextField(label: "Full Name", icon: Icons.person_outline),
                  _buildTextField(label: "User Name", icon: Icons.person_outline),
                  
                  // Highlighted Email Field (Active/Outline style)
                  _buildTextField(
                    label: "Email", 
                    initialValue: "ashutosh@user.com", 
                    icon: Icons.email_outlined, 
                    isHighlighted: true
                  ),
                  
                  _buildTextField(label: "Password", icon: Icons.visibility_off_outlined),
                  _buildTextField(label: "Phone Number", icon: Icons.phone_outlined),

                  // Dropdown Row
                  Row(
                    children: [
                      Expanded(child: _buildDropdownField(label: "City")),
                      const SizedBox(width: 16),
                      Expanded(child: _buildDropdownField(label: "State")),
                    ],
                  ),
                  
                  _buildDropdownField(label: "Country"),
                  _buildTextField(label: "Address", icon: Icons.location_on_outlined),

                  const SizedBox(height: 40),

                  // Bottom Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Verify ID", style: TextStyle(color: Colors.black, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF405FF2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label, 
    required IconData icon, 
    String? initialValue, 
    bool isHighlighted = false
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: isHighlighted ? label : null,
          hintText: isHighlighted ? null : label,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: Icon(icon, size: 20, color: Colors.grey),
          filled: !isHighlighted,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          // Normal Grey Border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: isHighlighted ? const Color(0xFF405FF2) : Colors.transparent),
          ),
          // Blue border when active (as seen in Email field)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF405FF2), width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        items: const [],
        onChanged: (val) {},
      ),
    );
  }
}
