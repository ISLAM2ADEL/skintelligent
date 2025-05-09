// import 'package:skintelligent/commons.dart';
// import 'package:skintelligent/controllers/repositories/user_repository.dart';
// import 'package:skintelligent/cubit/get_review_cubti/review_state.dart';

// class GetReviewCubit extends Cubit<GetReviewState> {
//   final UserRepository userRepository;
//   GetReviewCubit(this.userRepository) : super(ReviewInitial());
//   Future<void> getReview(int doctorID, int pageSize) async {
//     emit(ReviewLoading());
//     final response = await userRepository.getReviews(doctorID, pageSize);
//     response.fold(
//       (err) => emit(ReviewFailure(errMessage: err)),
//       (result) => emit(ReviewSuccess(review: result)),
//     );
//   }
// }
// review_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/models/get_review_model.dart';
import 'review_state.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';

class GetReviewCubit extends Cubit<GetReviewState> {
  final UserRepository userRepository;
  List<ReviewItem> allReviews = [];

  GetReviewCubit(this.userRepository) : super(ReviewInitial());

  Future<void> getReview(int doctorId, int limit) async {
    emit(ReviewLoading());
    final result = await userRepository.getReviews(doctorId, limit);
    result.fold(
      (failure) => emit(ReviewFailure(failure)),
      (response) {
        allReviews = response.reviews;
        emit(ReviewSuccess(response));
      },
    );
  }

  Future<void> loadMoreReviews(int doctorId, int limit) async {
    final result = await userRepository.getReviews(doctorId, limit);
    result.fold(
      (failure) => emit(ReviewFailure(failure)),
      (response) {
        allReviews = response.reviews;
        emit(ReviewSuccess(response));
      },
    );
  }
}
