import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/get_review_cubti/review_state.dart';

class GetReviewCubit extends Cubit<GetReviewState> {
  final UserRepository userRepository;
  GetReviewCubit(this.userRepository) : super(ReviewInitial());
  Future<void> getReview(int doctorID, int pageSize) async {
    emit(ReviewLoading());
    final response = await userRepository.getReviews(doctorID, pageSize);
    response.fold(
      (err) => emit(ReviewFailure(errMessage: err)),
      (result) => emit(ReviewSuccess(review: result)),
    );
  }
}
