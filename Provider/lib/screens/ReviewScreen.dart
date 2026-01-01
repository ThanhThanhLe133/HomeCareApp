import 'package:flutter/material.dart';
import '../widgets/CustomStatusBar.dart';
import '../BottomNav.dart';
import '../model/Review.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample review data
    final List<Review> reviews = [
      Review(
        userName: 'Tran Hoang Anh',
        handle: '@TranHoangAnh',
        serviceType: 'Lighting Repair',
        rating: 5,
        date: '17 Nov',
        comment: 'The technician fixed our faulty lights fast! He was professional, arrived on time, and the price was fair.',
      ),
      Review(
        userName: 'Pham Duc Son',
        handle: '@PhamDucSon',
        serviceType: 'Appliance Repair',
        rating: 4,
        date: '17 Nov',
        comment: 'Our dryer was making a horrible noise. The tech diagnosed and replaced the roller right away.',
      ),
      Review(
        userName: 'Le Thi B',
        handle: '@LeThiB',
        serviceType: 'Plumbing Service',
        rating: 4,
        date: '08 Oct',
        comment: 'Good work overall. The staff were polite and efficient. Will book again for future services.',
      ),
      Review(
        userName: 'Pham Minh C',
        handle: '@PhamMinhC',
        serviceType: 'Electrical Work',
        rating: 5,
        date: '05 Oct',
        comment: 'Outstanding! They completed the work ahead of schedule and did a fantastic job.',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CustomStatusBar(),
          AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
            ),
            title: const Text('All Reviews', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
            titleSpacing: 0,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _buildReviewItem(review);
              },
            ),
          ),
          SizedBox(
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
        ],
      ),
    );
  }

  Widget _buildReviewItem(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section: Avatar, Name, and Delete Icon
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey,
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      review.handle,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFF3B59FF),
                  size: 40.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Review Content Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.serviceType,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ...List.generate(
                      review.rating.toInt(),
                      (_) => const Icon(Icons.star, color: Color(0xFFFFB347), size: 24),
                    ),
                    ...List.generate(
                      5 - review.rating.toInt(),
                      (_) => Icon(Icons.star, color: Colors.grey[300], size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text('${review.rating}', style: const TextStyle(fontSize: 18, color: Colors.grey)),
                    const Spacer(),
                    Text(review.date, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  review.comment,
                  style: TextStyle(fontSize: 16, height: 1.4, color: Colors.grey[800]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
