import 'package:flutter/material.dart';
import '../widgets/CustomStatusBar.dart';

class CategoryItem {
  final String title;
  final IconData icon;
  CategoryItem(this.title, this.icon);
}

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for the categories
    final List<CategoryItem> categories = [
      CategoryItem('Plumber', Icons.plumbing),
      CategoryItem('Smart Home', Icons.home_outlined),
      CategoryItem('Painter', Icons.format_paint_outlined),
      CategoryItem('Pest Control', Icons.bug_report_outlined),
      CategoryItem('Carpenter', Icons.handyman_outlined),
      CategoryItem('Security', Icons.videocam_outlined),
      CategoryItem('AC Repair', Icons.ac_unit),
      CategoryItem('Salon', Icons.content_cut_outlined),
    ];

    return Column(
      children: [
        const CustomStatusBar(backgroundColor: Colors.white),
        Expanded(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
              ),
              title: const Text('Category', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // Header Text
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(text: 'You Have '),
                        TextSpan(text: '25 + ', style: TextStyle(color: Color(0xFF4361EE), fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Total Category'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // 1. Grid of Categories
                  Expanded(
                    child: GridView.builder(
                      itemCount: categories.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,          // 2 columns
                        crossAxisSpacing: 15,       // horizontal space
                        mainAxisSpacing: 15,        // vertical space
                        childAspectRatio: 0.85,     // Adjust height/width ratio
                      ),
                      itemBuilder: (context, index) {
                        return _buildCategoryCard(categories[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 2. Custom Card Widget
  Widget _buildCategoryCard(CategoryItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top section with light background and Icon
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F4FA), // Soft light blue/grey
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Icon(
                item.icon,
                size: 50,
                color: const Color(0xFF1D2D50), // Dark blue for icons
              ),
            ),
          ),
          // Bottom section with Title
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D2D50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
