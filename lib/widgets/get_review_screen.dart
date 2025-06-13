

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  final int pageSize = 5;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadInitialReviews();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !isLoadingMore) {
        _loadMoreReviews();
      }
    });
  }

  void _loadInitialReviews() {
    context.read<GetReviewCubit>().getReview(widget.doctorId, pageSize);
  }

  void _loadMoreReviews() async {
    setState(() => isLoadingMore = true);
    page++;
    await context
        .read<GetReviewCubit>()
        .loadMoreReviews(widget.doctorId, pageSize * page);
    setState(() => isLoadingMore = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          if (state is ReviewLoading && page == 1) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewSuccess) {
            final reviews = state.review.reviews;
            final totalCount = state.review.count;

            return ListView.builder(
              controller: _scrollController,
              itemCount: reviews.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < totalCount) {
                  final review = reviews[index];
                  return CustomReviewCard(
                    name: review.patientName,
                    rating: review.rating.toDouble(),
                    date: review.createdAt.split('T').first,
                    reviewText: review.comment,
                    imageUrl: review.patientImage,
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          }

          return const Center(child: Text('No Reviews'));
        },
      ),
    );
  }
}
