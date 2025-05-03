import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/widgets/get_review_screen.dart';
import 'package:skintelligent/widgets/make_review_screen.dart';
import 'package:skintelligent/cubit/get_review_cubti/review_cubit.dart';

class ReviewButtons extends StatelessWidget {
  final int doctorId;

  const ReviewButtons({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.read<GetReviewCubit>().getReview(doctorId, 100);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const GetReviewViewScreen()));
          },
          child: const Text("Show Reviews ", style: TextStyle(color: Colors.blue)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MakeReviewScreen(doctorID: doctorId)));
          },
          child: const Text("Write Reviews ", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
