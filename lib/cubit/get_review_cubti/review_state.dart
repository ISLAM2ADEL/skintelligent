import 'dart:io';
import '../../models/get_review_model.dart'; // Make sure to import dart:io for File

class GetReviewState {}

final class ReviewInitial extends GetReviewState {}

final class ReviewLoading extends GetReviewState {}

final class ReviewSuccess extends GetReviewState {
  final GetReviewModel review;

  ReviewSuccess({required this.review});
}

final class ReviewFailure extends GetReviewState {
  final String errMessage;

  ReviewFailure({required this.errMessage});
}
