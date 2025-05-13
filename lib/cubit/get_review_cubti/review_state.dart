// import 'dart:io';
// import '../../models/get_review_model.dart'; // Make sure to import dart:io for File

// class GetReviewState {}

// final class ReviewInitial extends GetReviewState {}

// final class ReviewLoading extends GetReviewState {}

// final class ReviewSuccess extends GetReviewState {
//   final GetReviewModel review;

//   ReviewSuccess({required this.review});
// }

// final class ReviewFailure extends GetReviewState {
//   final String errMessage;

//   ReviewFailure({required this.errMessage});
// }
// review_state.dart


import 'package:skintelligent/models/get_review_model.dart';

abstract class GetReviewState   {
  @override
  List<Object?> get props => [];
}

class ReviewInitial extends GetReviewState {}

class ReviewLoading extends GetReviewState {}

class ReviewSuccess extends GetReviewState {
  final GetReviewModel review;

  ReviewSuccess(this.review);

  @override
  List<Object?> get props => [review];
}

class ReviewFailure extends GetReviewState {
  final String errMessage;

  ReviewFailure(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
