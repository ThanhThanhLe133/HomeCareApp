import 'package:flutter/material.dart';
import '../widgets/CustomStatusBar.dart';
import '../BottomNav.dart';
import './ReviewScreen.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  bool _showDialog = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
        children: [
          const CustomStatusBar(),
          AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
            ),
            title: const Text('Pending', style: TextStyle(color: Colors.black)),
            titleSpacing: 0,
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _showDialog = true;
                  });
                },
                child: const Text("Check Status", style: TextStyle(color: Colors.black)),
              )
            ],
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              children: [
                  // Header: Booking ID and Service Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Booking ID", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Text("#123", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF405FF2))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Apartment Cleaning", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildTextRow("Date:", "17 November, 2025"),
                    _buildTextRow("Time:", "08:30 A.M"),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/image8.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                    );
                  },
                ),
              )
            ],
          ),

          const SizedBox(height: 24),
          _buildSectionTitle("About Houseman"),
          _buildContactCard("Hoang Quang Huy", "Cleaning Expert", showRating: true),

          const SizedBox(height: 24),
          _buildSectionTitle("About Customer"),
          _buildContactCard("Nguyen Hoang Son", "email@email.com", isCustomer: true),

          const SizedBox(height: 24),
          _buildSectionTitle("Payment Details"),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPaymentInfoRow('ID', '#123', valueColor: const Color(0xFF405FF2)),
                const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
                _buildPaymentInfoRow('Method', 'Cash'),
                const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
                _buildPaymentInfoRow('Status', 'Pending', valueColor: Colors.redAccent),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _buildSectionTitle("Price Details"),
          Container(
            decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                _buildInfoTile('Quantity', '*1', valColor: const Color(0xFF405FF2)),
                const Divider(height: 1),
                _buildInfoTile('Discount', '- 20,000VND'),
                const Divider(height: 1),
                _buildInfoTile('Coupon (AB45...)', '230,000VND'),
                const Divider(height: 1),
                _buildInfoTile('Subtotal', '230,000VND'),
                const Divider(height: 1, thickness: 2),
                _buildInfoTile('Total', '230,000VND', valColor: const Color(0xFF405FF2), isTotal: true),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReviewScreen()),
                  );
                },
                child: const Text("View All", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          _buildReviewTile(
            name: "Nguyen Hoang Son",
            date: "12 Oct",
            rating: 5,
            review: "Great experience! The technician knew exactly how to handle my smart thermostat issue.",
          ),
          const Divider(thickness: 1),
          _buildReviewTile(
            name: "Tran Van A",
            date: "10 Oct",
            rating: 5,
            review: "Excellent service and very professional. Highly recommend for anyone needing apartment cleaning.",
          ),
          const Divider(thickness: 1),
          _buildReviewTile(
            name: "Le Thi B",
            date: "08 Oct",
            rating: 4,
            review: "Good work overall. The staff were polite and efficient. Will book again for future services.",
          ),
          const Divider(thickness: 1),
          _buildReviewTile(
            name: "Pham Minh C",
            date: "05 Oct",
            rating: 5,
            review: "Outstanding! They completed the work ahead of schedule and did a fantastic job.",
          ),
              ],
            ),
          ),
          SizedBox(
            height: 98,
            child: BottomNav(
              initialIndex: 1,
              onTabChanged: (index) {
                // Navigate to BottomNav with the selected index
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => BottomNav(initialIndex: index)),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
          // Positioned button at y=812
          Positioned(
            top: 812,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // Cancel booking action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF405FF2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Cancel Booking',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // Status Dialog Overlay
          if (_showDialog)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Stack(
                children: [
                  // Dimmed background
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showDialog = false;
                      });
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  // Dialog positioned above nav bar
                  Positioned(
                    bottom: 98,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 439,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Booking ID",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  "#123",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showDialog = false;
                                    });
                                  },
                                  child: const Icon(Icons.close, size: 24),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                              child: Column(
                                children: [
                                  _buildTimelineItem(
                                    time: "01:17 PM",
                                    date: "16 Nov",
                                    title: "New Booking",
                                    subtitle: "New Booking Added By Customer",
                                    color: Colors.red,
                                    isLast: false,
                                  ),
                                  _buildTimelineItem(
                                    time: "01:21 PM",
                                    date: "16 Nov",
                                    title: "Accept Booking",
                                    subtitle: "Status Change from Pending To Accept",
                                    color: Colors.green,
                                    isLast: false,
                                  ),
                                  _buildTimelineItem(
                                    time: "01:12 PM",
                                    date: "16 Nov",
                                    title: "Assigned Booking",
                                    subtitle: "Booking Has Assigned To Nguyen Van Anh",
                                    color: Colors.orange,
                                    isLast: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // Navigation Bar (on top)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 98,
              child: BottomNav(
                initialIndex: 1,
                onTabChanged: (index) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => BottomNav(initialIndex: index)),
                    (route) => false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildTimelineItem({
    required String time,
    required String date,
    required String title,
    required String subtitle,
    required Color color,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time and Date Section
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(date, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          // Timeline Line and Dot
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Content Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                const SizedBox(height: 30), // Spacing between items
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(text: "$label ", style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(String name, String subtitle, {bool showRating = false, bool isCustomer = false}) {
    if (showRating) {
      // Houseman card with new design
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Section: Avatar and Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFFE0E0E0),
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ...List.generate(5, (index) => const Icon(
                            Icons.star, color: Colors.orangeAccent, size: 24
                          )),
                          const SizedBox(width: 10),
                          const Text('5', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF405FF2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Call', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF405FF2),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Chat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Footer Text
            TextButton(
              onPressed: () {},
              child: const Text(
                'Rate Houseman',
                style: TextStyle(
                  color: Color(0xFF405FF2),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Customer card (new design)
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile Information
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 42,
                  backgroundColor: Color(0xFFE0E0E0),
                  child: Icon(Icons.person, size: 55, color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Email Row
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, size: 24),
                          const SizedBox(width: 12),
                          Text(subtitle, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Location Row
                      const Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 24),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Nguyen Van Troi, Phu Nhuan,...',
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Call & Chat Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF405FF2),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Call', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF405FF2),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Chat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _buildButton(String label, IconData icon, Color color, {bool isOutlined = false}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: isOutlined ? BorderSide(color: Colors.grey[200]!) : BorderSide.none,
        ),
      ),
      child: Text(label, style: TextStyle(color: isOutlined ? const Color(0xFF405FF2) : Colors.white)),
    );
  }

  Widget _buildDetailBox(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(16)),
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 18 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: isTotal ? 18 : 14, fontWeight: FontWeight.bold, color: valueColor ?? (isTotal ? const Color(0xFF405FF2) : Colors.black))),
        ],
      ),
    );
  }

  Widget _buildReviewItem() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(backgroundColor: Colors.grey),
          title: const Text("Nguyen Hoang Son", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("Great experience! The technician knew exactly how to handle my thermostat."),
          trailing: const Text("12 Oct", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildPaymentInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: valueColor ?? const Color(0xFF2D2D2D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, {Color? valColor, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 22 : 18, fontWeight: isTotal ? FontWeight.bold : FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: isTotal ? 22 : 18, fontWeight: FontWeight.bold, color: valColor)),
        ],
      ),
    );
  }

  Widget _buildReviewTile({
    required String name,
    required String date,
    required int rating,
    required String review,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Avatar
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(Icons.person, size: 50, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              // Name, Date, and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ...List.generate(rating, (index) => const Icon(
                          Icons.star,
                          color: Color(0xFFFFB347),
                          size: 24,
                        )),
                        ...List.generate(5 - rating, (index) => Icon(
                          Icons.star,
                          color: Colors.grey[300],
                          size: 24,
                        )),
                        const SizedBox(width: 12),
                        Text(
                          '$rating',
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Review Text
          Text(
            review,
            style: const TextStyle(
              fontSize: 18,
              height: 1.4,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ],
      ),
    );
  }
}