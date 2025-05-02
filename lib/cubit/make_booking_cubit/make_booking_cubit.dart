import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/make_booking_cubit/make_booking_state.dart';

class MakeReviewCubit extends Cubit<MakeBookginState> {
  final UserRepository userRepository;
  MakeReviewCubit(this.userRepository) : super(BookingInitial());

  Future<void> makeReview({required int appointmentId}) async {
    emit(BookingLoading());
    try {
      final response =
          await userRepository.makeBooking(appointmentId: appointmentId);

      response.fold(
        (err) => emit(BookingFailure(errMessage: err)),
        (result) => emit(BookingSuccess(booking: result)),
      );
    } catch (e) {
      emit(BookingFailure(errMessage: '❌ Error ${e.toString()}'));
    }
  }
}
