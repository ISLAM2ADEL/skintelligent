// import 'package:skintelligent/commons.dart';
// import 'package:skintelligent/cubit/review_cubti/review_cubit.dart';
// import 'package:skintelligent/cubit/review_cubti/review_state.dart';

// class ReviewViewScreen extends StatelessWidget {
//   const ReviewViewScreen({super.key , required this.doctorID});
//   final int doctorID;
//   final int pageSize = 1;
//   static final String id = "ReviewViewScreen";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Doctor Reviews')),
//       body: BlocBuilder<ReviewCubit, ReviewState>(
//         builder: (context, state) {
//           if (state is ReviewLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ReviewFailure) {
//             return Center(child: Text('Failed: ${state.errMessage}'));
//           } else if (state is ReviewSuccess) {
//             final reviews = state.review.reviews;
//             return ListView.builder(
//               itemCount: reviews.length,
//               itemBuilder: (context, index) {
//                 final review = reviews[index];
//                 return Card(
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(review.patientImage),
//                     ),
//                     title: Text(review.patientName),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(review.comment),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Rating: ${review.rating} ⭐',
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         Text('Date: ${review.createdAt}'),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           return const Center(child: Text('No Reviews'));
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/get_review_cubti/review_cubit.dart';
import 'package:skintelligent/cubit/get_review_cubti/review_state.dart';
import 'package:skintelligent/widgets/custom_review_card.dart';

class GetReviewViewScreen extends StatefulWidget {
  const GetReviewViewScreen({super.key});
  static final String id = "ReviewViewScreen";

  @override
  State<GetReviewViewScreen> createState() => _GetReviewViewScreenState();
}

class _GetReviewViewScreenState extends State<GetReviewViewScreen> {
  final int pageSize = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Reviews')),
      body: BlocConsumer<GetReviewCubit, GetReviewState>(
        listener: (context, state) {
          if (state is ReviewFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        builder: (context, state) {
          if (state is ReviewLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewSuccess) {
            final reviews = state.review.reviews;
            if (reviews.isEmpty) return const Center(child: Text('No Reviews'));

            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return CustomReviewCard(
                  name: review.patientName,
                  rating: review.rating.toDouble(),
                  date: review.createdAt.split('T').first, // Format as needed
                  reviewText: review.comment,
                  imageUrl: review.patientImage,
                );
              },
            );
          }
          return const Center(child: Text('No Reviews'));
        },
      ),
    );
  }
}
