import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/make_review_cubit/make_review_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MakeReviewCubit extends Cubit<MakeReviewState> {
  final UserRepository userRepository;
  MakeReviewCubit(this.userRepository) : super(ReviewInitial());
  TextEditingController addComment = TextEditingController();
  TextEditingController addRate = TextEditingController();

  // Future<void> makeReview({required int doctorID}) async {
  //   emit(ReviewLoading());
  //   final token = await getIt<CacheHelper>().getData(key: ApiKey.Authorization);
  //   final decodedToken = JwtDecoder.decode(token);
  //   final patientId = decodedToken[ApiKey.patientId];
  //   print("🧾 patientId: $patientId, type: ${patientId.runtimeType}");
  //   print(
  //       "💬 comment: ${addComment.text}, type: ${addComment.text.runtimeType}");
  //   print("⭐ rate: ${addRate.text}, type: ${addRate.text.runtimeType}");
  //   print("🩺 doctorID: $doctorID, type: ${doctorID.runtimeType}");

  //   final response = await userRepository.makeReview(
  //     comment: addComment.text,
  //     rating: int.parse(addRate.text.trim()),
  //     patientID: patientId,
  //     doctorID: doctorID,
  //   );
  //   response.fold(
  //     (err) => emit(ReviewFailure(errMessage: err)),
  //     (result) => emit(ReviewSuccess(review: result)),
  //   );
  // }
  Future<void> makeReview(
      {required int doctorID, required int clinicID}) async {
    emit(ReviewLoading());
    try {
// غالبًا int أصلاً
      final rating = int.parse(addRate.text.trim());
      // print(" patientId: $patientId, type: ${patientId.runtimeType}");
      // print(
      //     " comment: ${addComment.text}, type: ${addComment.text.runtimeType}");
      // print(" rate: ${addRate.text}, type: ${addRate.text.runtimeType}");
      // print("doctorID: $doctorID, type: ${doctorID.runtimeType}");
      if (rating < 1 || rating > 5) {
        emit(ReviewFailure(errMessage: '❌ Rate must be between 1 and '));
        return;
      }

      final response = await userRepository.makeReview(
        comment: addComment.text,
        rating: rating,
        clinicID: clinicID, // بدون int.parse
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
