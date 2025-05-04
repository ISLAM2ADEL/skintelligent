import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/get_review_cubti/review_cubit.dart';
import 'package:skintelligent/cubit/get_review_cubti/review_state.dart';
import 'package:skintelligent/widgets/custom_review_card.dart';

class GetReviewViewScreen extends StatefulWidget {
  const GetReviewViewScreen({super.key, required this.doctorId});
  final int doctorId;
  static final String id = "ReviewViewScreen";

  @override
  State<GetReviewViewScreen> createState() => _GetReviewViewScreenState();
}

class _GetReviewViewScreenState extends State<GetReviewViewScreen> {
  final int pageSize = 10;
  @override
  void initState() {
    super.initState();
    context.read<GetReviewCubit>().getReview(widget.doctorId, pageSize, 1);
  }

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
            final reviews = [...state.review.reviews]
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
            if (reviews.isEmpty) return const Center(child: Text('No Reviews'));

            return ListView.builder(
              itemCount: state.review.count,
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
