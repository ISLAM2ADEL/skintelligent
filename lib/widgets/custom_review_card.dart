import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomReviewCard extends StatelessWidget {
  final String name;
  final double rating;
  final String date;
  final String reviewText;
  final String imageUrl;

  const CustomReviewCard({
    super.key,
    required this.name,
    required this.rating,
    required this.date,
    required this.reviewText,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name & avatar
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(imageUrl),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(width: 8),
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),

            // Rating + title
            Row(
              children: [
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.orange),
                  itemCount: 5,
                  itemSize: 18.0,
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 4),

            // Meta info
            Text(
              "Date: $date",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),

            const SizedBox(height: 8),

            // Review text
            Text(
              reviewText,
            ),
          ],
        ),
      ),
    );
  }
}
