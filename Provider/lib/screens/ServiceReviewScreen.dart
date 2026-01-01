import 'package:flutter/material.dart';

class ServiceReviewScreen extends StatelessWidget {
  const ServiceReviewScreen({super.key});

  static const List<Map<String, dynamic>> reviews = [
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
      'comment': 'Excellent work! Highly recommended. Very satisfied with the service.',
    },
    {
      'name': 'Mike Johnson',
      'date': '28 Nov',
      'rating': 4.0,
      'comment': 'Good service, completed on time. Would use again.',
    },
    {
      'name': 'Emma Wilson',
      'date': '25 Nov',
      'rating': 5.0,
      'comment': 'Outstanding! The technician was very professional and thorough.',
    },
    {
      'name': 'David Brown',
      'date': '20 Nov',
      'rating': 4.0,
      'comment': 'Good quality work. Fair pricing. Will hire again.',
    },
    {
      'name': 'Lisa Anderson',
      'date': '18 Nov',
      'rating': 5.0,
      'comment': 'Amazing service! Everything was perfect. Highly satisfied.',
    },
    {
      'name': 'James Taylor',
      'date': '15 Nov',
      'rating': 3.5,
      'comment': 'Decent service. Could be a bit faster.',
    },
    {
      'name': 'Maria Garcia',
      'date': '12 Nov',
      'rating': 5.0,
      'comment': 'Perfect! Exactly what I needed. Excellent customer service.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4361EE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        title: const Text(
          'Reviews',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return _buildReviewCard(review);
        },
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
                radius: 25,
                backgroundColor: const Color(0xFF4361EE).withOpacity(0.1),
                child: Text(
                  review['name'][0],
                  style: const TextStyle(
                    color: Color(0xFF4361EE),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
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
          const SizedBox(height: 12),
          Row(
            children: [
              ...List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: index < (review['rating'] as double).toInt()
                      ? Colors.orange
                      : Colors.grey[300],
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${review['rating']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF4361EE),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review['comment'],
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
