import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../widgets/CustomStatusBar.dart';
import 'CategoryScreen.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomStatusBar(backgroundColor: Color(0xFFF8F9FD)),
        Expanded(
          child: Scaffold(
            backgroundColor: const Color(0xFFF8F9FD),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
              ),
              title: const Text('Add Service', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

            // 1. Image Picker Section
            DottedBorder(
              color: const Color(0xFF4361EE),
              strokeWidth: 1.5,
              dashPattern: const [6, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined, size: 40, color: Colors.grey[600]),
                    const SizedBox(height: 8),
                    const Text('Choose Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Support : JPG , PNG, JPEG', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 30),

            // 2. Form Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // Service Name with floating label on border
                  _buildServiceTextField(),
                  const SizedBox(height: 16),

                  _buildDropdown(context, 'Select Category', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),

                  _buildDropdown(context, 'Select Address'),
                  const SizedBox(height: 16),

                  // Row for Type and Status
                  Row(
                    children: [
                      Expanded(child: _buildDropdown(context, 'Type')),
                      const SizedBox(width: 16),
                      Expanded(child: _buildDropdown(context, 'Status')),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Row for Price and Discount
                  Row(
                    children: [
                      Expanded(child: _buildDropdown(context, 'Price')),
                      const SizedBox(width: 16),
                      Expanded(child: _buildDropdown(context, 'Discount')),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Row for Duration
                  Row(
                    children: [
                      Expanded(child: _buildSimpleInput('Duration Hours')),
                      const SizedBox(width: 16),
                      Expanded(child: _buildSimpleInput('Duration Mint.')),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildSimpleInput('Description of service', maxLines: 3),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 3. Save Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4361EE),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    ),
        ),
      ],
    );
  }

  // Widget for the specialized "Service Name" field
  Widget _buildServiceTextField() {
    return TextFormField(
      initialValue: 'Car Washing',
      decoration: InputDecoration(
        labelText: 'Service Name',
        labelStyle: const TextStyle(color: Color(0xFF4361EE)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4361EE)),
        ),
      ),
    );
  }

  // General Dropdown Builder
  Widget _buildDropdown(BuildContext context, String hint, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(hint, style: const TextStyle(color: Colors.grey)),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Simple Input Field Builder
  Widget _buildSimpleInput(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
