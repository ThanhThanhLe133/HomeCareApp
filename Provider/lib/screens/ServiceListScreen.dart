import 'package:flutter/material.dart';
import '../widgets/CustomStatusBar.dart';
import 'AddServiceScreen.dart';
import 'ServiceDetailScreen.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  bool _isGridView = true;

  static const _services = [
    {
      'title': 'Painting For Beautiful Homes...',
      'name': 'Emma Grate',
      'price': '₹150',
      'rating': 4.3,
      'image': 'assets/images/image1.png',
    },
    {
      'title': 'Painting For Beautiful Homes...',
      'name': 'Penny Black',
      'price': '₹150',
      'rating': 4.3,
      'image': 'assets/images/image2.png',
    },
    {
      'title': 'Electronic Devices And Repair...',
      'name': 'Manuel Labor',
      'price': '₹150',
      'rating': 4.3,
      'image': 'assets/images/image3.png',
    },
    {
      'title': 'Salon At Home With Extra...',
      'name': 'Lee Nonmi',
      'price': '₹150',
      'rating': 4.3,
      'image': 'assets/images/image4.png',
    },
    {
      'title': 'Home Cleaning And Disinfection...',
      'name': 'Abby Normal',
      'price': '₹150',
      'rating': 4.3,
      'image': 'assets/images/image5.png',
    },
    {
      'title': 'Fixing TV Wire And Install...',
      'name': 'Annie Versaree',
      'price': '₹150',
      'rating': 4.3,
      'image': 'assets/images/image6.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: const CustomStatusBar(),
        ),
        Expanded(
          child: Scaffold(
            backgroundColor: const Color(0xFFF5F7FB),
            appBar: AppBar(
              titleSpacing: 0,
              title: const Text(
                'Service List',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              backgroundColor: const Color(0xFFF5F7FB),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddServiceScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search here...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Grid or List
          Expanded(
            child: _isGridView
                ? GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 157 / 249,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _services.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetailScreen(
                              serviceData: _services[index],
                            ),
                          ),
                        );
                      },
                      child: _ServiceCard(data: _services[index], isGrid: true),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: _services.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailScreen(
                                serviceData: _services[index],
                              ),
                            ),
                          );
                        },
                        child: _ServiceCard(data: _services[index], isGrid: false),
                      ),
                    ),
                  ),
            ),
          ],
        ),
          ),
        ),
        const _BottomNavBar(),
      ],
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Navigation section (74px)
          SizedBox(
            height: 74,
            child: BottomNavigationBar(
              currentIndex: 0, // Always highlight Home
              onTap: (index) {
                if (index == 0) {
                  // Navigate back to home
                  Navigator.pop(context);
                } else if (index == 1) {
                  // Navigate to Booking
                  Navigator.pushReplacementNamed(context, '/booking');
                } else if (index == 2) {
                  // Navigate to Notification
                  Navigator.pushReplacementNamed(context, '/notification');
                } else if (index == 3) {
                  // Navigate to Account
                  Navigator.pushReplacementNamed(context, '/account');
                }
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xFF405FF2),
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.confirmation_number_outlined),
                  label: 'Booking',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_box_outlined),
                  label: 'Account',
                ),
              ],
            ),
          ),
          // Black indicator bar at bottom (24px remaining for 98 total)
          Container(
            width: 120,
            height: 5,
            margin: const EdgeInsets.only(top: 8, bottom: 11),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isGrid;

  const _ServiceCard({required this.data, this.isGrid = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: isGrid ? _buildGridCard() : _buildListCard(),
    );
  }

  Widget _buildGridCard() {
    return SizedBox(
      width: 157,
      height: 249,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with badges
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  data['image'] as String,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.black,
                    );
                  },
                ),
              ),
              // Category chip
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'PAINTING',
                    style: TextStyle(
                      color: Color(0xFF405FF2),
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Price badge (floating)
              Positioned(
                bottom: -12,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF405FF2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Text(
                    data['price'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Bottom content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${data['rating']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data['title'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xFF1A1D1E),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: const Offset(0, -10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey[300],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            data['name'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard() {
    return SizedBox(
      width: 335,
      height: 130,
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Stack(
              children: [
                Image.asset(
                  data['image'] as String,
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 130,
                      width: 130,
                      color: Colors.black,
                    );
                  },
                ),
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF405FF2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Text(
                      data['price'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'PAINTING',
                          style: TextStyle(
                            color: Color(0xFF405FF2),
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data['title'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF1A1D1E),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${data['rating']}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey[300],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          data['name'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
