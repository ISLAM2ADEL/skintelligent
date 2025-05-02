import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/make_review_cubit/make_review_cubit.dart';
import 'package:skintelligent/cubit/make_review_cubit/make_review_state.dart';
import 'package:skintelligent/widgets/comment_text_field.dart';

class MakeReviewScreen extends StatelessWidget {
  const MakeReviewScreen({super.key, required this.doctorID});
  static const String id = "MakeReviewScreen";
  final int doctorID; // Replace with actual doctor ID
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MakeReviewCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<MakeReviewCubit, MakeReviewState>(
          listener: (context, state) {
            if (state is ReviewSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.review.message}')),
              );
              Navigator.pop(context); // Optionally pop the screen
            } else if (state is ReviewFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMessage}')),
              );
              cubit.addComment.clear();
              cubit.addRate.clear();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                commentTextField(controller: cubit.addComment),
                const SizedBox(height: 20),
                TextField(
                  controller: cubit.addRate,
                  decoration: const InputDecoration(
                      labelText: 'Rating (1-5)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                state is ReviewLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          // Validate and parse
                          try {
                            cubit.makeReview(doctorID: doctorID);
                            // cubit.addComment.clear();
                            // cubit.addRate.clear();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Please enter valid integers ${e.toString()}')),
                            );
                          }
                        },
                        child: const Text('Submit Review'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
