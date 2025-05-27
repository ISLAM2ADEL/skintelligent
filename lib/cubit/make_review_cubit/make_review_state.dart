import 'package:skintelligent/models/make_review_model.dart';

class MakeReviewState {}

final class ReviewInitial extends MakeReviewState {}

final class ReviewLoading extends MakeReviewState {}

final class ReviewSuccess extends MakeReviewState {
  final MakeReviewModel review;

  ReviewSuccess({required this.review});
}

final class ReviewFailure extends MakeReviewState {
  final String errMessage;

  ReviewFailure({required this.errMessage});
}
