import 'dart:io';
import '../../models/review_model.dart'; // Make sure to import dart:io for File

class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class ReviewLoading extends ReviewState {}

final class ReviewSuccess extends ReviewState {
  final ReviewModel review;

  ReviewSuccess({required this.review});
}

final class ReviewFailure extends ReviewState {
  final String errMessage;

  ReviewFailure({required this.errMessage});
}


