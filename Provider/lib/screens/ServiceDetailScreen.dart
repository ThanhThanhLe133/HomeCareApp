import 'package:flutter/material.dart';
import 'ServiceReviewScreen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? serviceData;

  const ServiceDetailScreen({super.key, this.serviceData});

  static const List<Map<String, dynamic>> sampleReviews = [
    {
      'name': 'John Doe',
      'date': '02 Dec',
      'rating': 4.5,
      'comment': 'Professional and quick service!',
    },
    {
      'name': 'Sarah Smith',
      'date': '01 Dec',
      'rating': 5.0,
      'comment': 'Excellent work! Highly recommended.',
    },
    {
      'name': 'Mike Johnson',
      'date': '28 Nov',
      'rating': 4.0,
      'comment': 'Good service, completed on time.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header with Image
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 350,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/image10.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 350,
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.image, size: 50)),
                          );
                        },
                      ),
                    ),
                    // 2. The Floating Information Card
                    Positioned(
                      top: 250,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serviceData?['title'] ?? 'TV Wall Mount Installation',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  serviceData?['price'] ?? 'VND 150,000',
                                  style: const TextStyle(
                                    color: Color(0xFF4361EE),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '10% off',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            const Divider(height: 30),
                            _buildRowInfo('Duration :', '01 Hour'),
                            const SizedBox(height: 8),
                            _buildRowInfo(
                              'Rating :',
                              '${serviceData?['rating'] ?? 4.5}',
                              isRating: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Extra spacing to accommodate the floating card
                const SizedBox(height: 120),

                // 3. Description Section
                _buildSectionHeader('Description'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Professional service provided by experienced technicians with high-quality standards.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),

                // 4. Gallery Section
                _buildSectionHeader('Gallery', trailing: 'View All'),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    children: [
                      _buildGalleryItemAsset('assets/images/image11.png'),
                      _buildGalleryItemAsset('assets/images/image12.png'),
                      _buildGalleryItemAsset('assets/images/image13.png'),
                    ],
                  ),
                ),

                // 5. Reviews Section
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Reviews', trailing: 'View All', onViewAllTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ServiceReviewScreen(),
                          ),
                        );
                      }),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemCount: sampleReviews.length,
                        itemBuilder: (context, index) {
                          final review = sampleReviews[index];
                          return _buildReviewItem(review);
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Fixed Back and Menu buttons
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: _buildCircleButton(Icons.arrow_back_ios_new),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: _buildCircleButton(Icons.more_horiz),
          ),
        ],
      ),
    );
  }

  // Helper widgets for repetitive UI elements
  Widget _buildCircleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF4361EE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildRowInfo(String label, String value, {bool isRating = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            if (isRating)
              const Icon(Icons.star, color: Colors.orange, size: 18),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF4361EE),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {String? trailing, VoidCallback? onViewAllTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (trailing != null)
            GestureDetector(
              onTap: onViewAllTap,
              child: Text(trailing, style: const TextStyle(color: Colors.grey)),
            ),
        ],
      ),
    );
  }

  Widget _buildGalleryItem(String url, {bool hasOverlay = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
      child: hasOverlay
          ? const Center(child: Icon(Icons.stars, color: Colors.white, size: 30))
          : null,
    );
  }

  Widget _buildGalleryItemAsset(String assetPath) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(assetPath), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF4361EE).withOpacity(0.1),
                child: Text(
                  review['name'][0],
                  style: const TextStyle(
                    color: Color(0xFF4361EE),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      review['date'],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ...List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: index < (review['rating'] as double).toInt()
                      ? Colors.orange
                      : Colors.grey[300],
                  size: 14,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '${review['rating']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color(0xFF4361EE),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review['comment'],
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
