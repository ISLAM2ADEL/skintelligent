import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/user_booking_cubit/user_booking_state.dart';

class UserBookingCubit extends Cubit<UserBookingState> {
  final UserRepository repository;

  UserBookingCubit(this.repository) : super(UserBookingInitial());

  Future<void> fetchBookings() async {
    emit(UserBookingLoading());

    final response = await repository.getMyBookings();

    response.fold(
      (error) => emit(UserBookingFailure(error)),
      (bookings) => emit(UserBookingSuccess(bookings)),
    );
  }
}
