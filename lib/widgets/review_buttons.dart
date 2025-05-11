import 'package:flutter/material.dart';
import 'package:skintelligent/widgets/get_review_screen.dart';
import 'package:skintelligent/widgets/make_review_screen.dart';

class ReviewButtons extends StatelessWidget {
  final int doctorId;
  final int clinicId;

  const ReviewButtons(
      {super.key, required this.doctorId, required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => GetReviewViewScreen(doctorId: doctorId)));
          },
          child:
              const Text("Show Reviews ", style: TextStyle(color: Colors.blue)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MakeReviewScreen(
                        doctorID: doctorId, clinicID: clinicId)));
          },
          child: const Text("Write Reviews ",
              style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
