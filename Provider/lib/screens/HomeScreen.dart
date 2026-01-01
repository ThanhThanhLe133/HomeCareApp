import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'ServiceListScreen.dart';
import 'ServiceDetailScreen.dart';
import 'PaymentHistoryScreen.dart';
import 'BookingScreen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? onNavigateToTab;
  
  const HomeScreen({super.key, this.onNavigateToTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  bool _showServicesTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final ctx = _servicesKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject();
    if (box is RenderBox) {
      final pos = box.localToGlobal(Offset.zero);
      final safeTop = MediaQuery.of(context).padding.top + kToolbarHeight;
      final shouldShow = pos.dy <= safeTop + 8;
      if (shouldShow != _showServicesTitle) {
        setState(() => _showServicesTitle = shouldShow);
      }
    }
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F7FB),
        title: Text(
          _showServicesTitle ? 'Services' : 'Home',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: _showServicesTitle
            ? [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ServiceListScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ]
            : [
                IconButton(
                  icon:
                      const Icon(Icons.notifications_none, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.person_outline, color: Colors.black),
                  onPressed: () {},
                ),
              ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _commissionCard(),
            const SizedBox(height: 16),
            _statsGrid(),
            const SizedBox(height: 24),
            _revenueChart(),
            const SizedBox(height: 24),
            _servicesSection(key: _servicesKey),
          ],
        ),
      ),
    );
  }

  Widget _commissionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Commission Type : Company',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 6),
                Text(
                  'My Commission : INR 20 (Fixed)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFF405FF2),
            child:
                const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _statsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        GestureDetector(
          onTap: () {
            if (widget.onNavigateToTab != null) {
              widget.onNavigateToTab!(1); // Navigate to Booking tab (index 1)
            }
          },
          child: const _StatCard(
            title: 'Total Booking',
            value: '98',
            icon: Icons.confirmation_number_outlined,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ServiceListScreen(),
              ),
            );
          },
          child: const _StatCard(
            title: 'Total Service',
            value: '15',
            icon: Icons.receipt_long_outlined,
          ),
        ),
        const _StatCard(
          title: 'Houseman',
          value: '30',
          icon: Icons.groups_outlined,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentHistoryScreen(),
              ),
            );
          },
          child: const _StatCard(
            title: 'Total Earning',
            value: '\$45.3',
            icon: Icons.workspace_premium_outlined,
          ),
        ),
      ],
    );
  }

  Widget _revenueChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Monthly Revenue USD',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const months = [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug'
                      ];
                      return Text(months[value.toInt()]);
                    },
                  ),
                ),
              ),
              barGroups: [
                _barGroup(0, 5000),
                _barGroup(1, 10000),
                _barGroup(2, 0),
                _barGroup(3, 0),
                _barGroup(4, 0),
                _barGroup(5, 0),
                _barGroup(6, 0),
                _barGroup(7, 0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData _barGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 12,
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFF405FF2),
        ),
      ],
    );
  }

  Widget _servicesSection({Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Services',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServiceListScreen(),
                    ),
                  );
                },
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: _services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // Target ~157w x 249h cards (aspect ~0.63)
            childAspectRatio: 157 / 249,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
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
            child: _ServiceCard(data: _services[index]),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF405FF2),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF405FF2).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18,
              color: const Color(0xFF405FF2),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const _ServiceCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 157,
      height: 249,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FB),
          borderRadius: BorderRadius.circular(16),
        ),
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
      ),
    );
  }
}
