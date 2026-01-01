import 'package:flutter/material.dart';
import 'BookingDetailsScreen.dart';

class Houseman {
  final String name;
  final String memberSince;
  Houseman(this.name, this.memberSince);
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool _showSummaryDialog = false;
  bool _showAssignDialog = false;
  int? _selectedHousemanIndex;

  final List<Houseman> housemen = [
    Houseman('Hoang Tuan Anh', '2015'),
    Houseman('Tran Van Tu', '2015'),
    Houseman('Nguyen Thanh Thao', '2016'),
    Houseman('Pham Yen Vy', '2018'),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF405FF2)),
                borderRadius: BorderRadius.circular(25),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: 'All',
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  items: ['All', 'Pending', 'Completed'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(color: Color(0xFF405FF2), fontSize: 18)),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildBookingCard(
                context: context,
                title: "Apartment Cleaning",
                id: "#123",
                price: "230,000 VND",
                status: "Pending",
                statusColor: Colors.redAccent,
                location: "Nguyen Van Troi, Phu Nhuan, Ho Chi Minh City",
                dateTime: "17 November, 2025 At 8:30 AM",
                provider: "Nguyen Hoang Son",
                imageAsset: 'assets/images/image8.png',
                showButtons: true,
              ),
              const SizedBox(height: 16),
              _buildBookingCard(
                context: context,
                title: "AC Reparation",
                id: "#122",
                price: "370,000 VND",
                status: "Completed",
                statusColor: Colors.green,
                location: "Nguyen Van Troi, Phu Nhuan, Ho Chi Minh City",
                dateTime: "15 November, 2025 At 10:00 AM",
                provider: "Tran Van A",
                imageAsset: 'assets/images/image9.png',
                showButtons: false,
              ),
            ],
          ),
        ),
        // Booking Summary Dialog Overlay
        if (_showSummaryDialog)
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
                      _showSummaryDialog = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                // Dialog
                Center(
                  child: Container(
                    width: 383,
                    height: 584,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header Section
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Color(0xFF4A69FF),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Booking Summary',
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showSummaryDialog = false;
                                    });
                                  },
                                  child: const Icon(Icons.close, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Banner Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      'assets/images/image8.png',
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: 100,
                                          width: double.infinity,
                                          color: Colors.grey[300],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Title and ID Tag
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Apartment Cleaning',
                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF4A69FF),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Text('#123', style: TextStyle(color: Colors.white, fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Data Rows
                                  _buildDialogInfoRow('Date', '17 November, 2025'),
                                  _buildDialogInfoRow('Time', '08:30 AM'),
                                  _buildDialogInfoRow('Location', 'Nguyen Van Troi, Phu Nhuan,\nHo Chi Minh City'),
                                  _buildDialogInfoRow('Service Status', 'Accepted'),
                                  _buildDialogInfoRow('Quantity', '*1'),
                                  _buildDialogInfoRow('Payment Status', 'Pending'),
                                  const SizedBox(height: 12),
                                  // Confirm Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 42,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF4A69FF),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showSummaryDialog = false;
                                          _showAssignDialog = true;
                                          _selectedHousemanIndex = 1; // Default to second item
                                        });
                                      },
                                      child: const Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        // Assign Houseman Dialog Overlay
        if (_showAssignDialog)
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
                      _showAssignDialog = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                // Dialog
                Center(
                  child: Container(
                    width: 383,
                    height: 584,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header Section
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: const BoxDecoration(
                              color: Color(0xFF4361EE),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Assign Houseman',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showAssignDialog = false;
                                    });
                                  },
                                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                                ),
                              ],
                            ),
                          ),
                          // List of Housemen
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              itemCount: housemen.length,
                              separatorBuilder: (context, index) => const Divider(indent: 16, endIndent: 16, height: 1),
                              itemBuilder: (context, index) {
                                final person = housemen[index];
                                bool isSelected = _selectedHousemanIndex == index;

                                return ListTile(
                                  onTap: () => setState(() => _selectedHousemanIndex = index),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  leading: const CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Color(0xFFE0E0E0),
                                    child: Icon(Icons.person, color: Colors.white, size: 36),
                                  ),
                                  title: Text(
                                    person.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    'Member since ${person.memberSince}',
                                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                                  ),
                                  trailing: Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF4361EE),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected ? const Color(0xFF4361EE) : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Confirm Button
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _showAssignDialog = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4361EE),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                ),
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBookingCard({
    required BuildContext context,
    required String title,
    required String id,
    required String price,
    required String status,
    required Color statusColor,
    required String location,
    required String dateTime,
    required String provider,
    required String imageAsset,
    required bool showButtons,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingDetailsScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  imageAsset,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      width: double.infinity,
                      color: Colors.grey[300],
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFF405FF2), borderRadius: BorderRadius.circular(10)),
                      child: Text(id, style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF405FF2))),
                const SizedBox(height: 12),
                
                _buildInfoRow(Icons.location_on_outlined, location),
                _buildInfoRow(Icons.calendar_today_outlined, dateTime),
                _buildInfoRow(Icons.person_outline, provider),
                
                if (showButtons) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showSummaryDialog = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF405FF2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text("Accept", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF405FF2).withOpacity(0.05),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text("Decline", style: TextStyle(color: Color(0xFF405FF2))),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black87),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildDialogInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
          const Divider(thickness: 0.5, height: 8),
        ],
      ),
    );
  }
}
