import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/make_review_cubit/make_review_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MakeReviewCubit extends Cubit<MakeReviewState> {
  final UserRepository userRepository;
  MakeReviewCubit(this.userRepository) : super(ReviewInitial());
  TextEditingController addComment = TextEditingController();
  TextEditingController addRate = TextEditingController();


  Future<void> makeReview(
      {required int doctorID, required int clinicID}) async {
    emit(ReviewLoading());
    try {
      final rating = int.parse(addRate.text.trim());

      if (rating < 1 || rating > 5) {
        emit(ReviewFailure(errMessage: '❌ Rate must be between 1 and '));
        return;
      }

      final response = await userRepository.makeReview(
        comment: addComment.text,
        rating: rating,
        clinicID: clinicID, 
        doctorID: doctorID,
      );

      response.fold(
        (err) => emit(ReviewFailure(errMessage: err)),
        (result) => emit(ReviewSuccess(review: result)),
      );
    } catch (e) {
      emit(ReviewFailure(errMessage: '❌ Error ${e.toString()}'));
    }
  }
}
