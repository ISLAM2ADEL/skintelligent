import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/review_cubti/review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final UserRepository userRepository;
  ReviewCubit(this.userRepository) : super(ReviewInitial());
  Future<void> getReview(int doctorID, int pageSize) async {
    emit(ReviewLoading());
    final response = await userRepository.getReviews(doctorID, pageSize);
    response.fold(
      (err) => emit(ReviewFailure(errMessage: err)),
      (result) => emit(ReviewSuccess(review: result)),
    );
  }
}

