import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/models/available_booking_model.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_state.dart';

class AvailableBookingCubit extends Cubit<AvailableBookingState> {
  final UserRepository repository;

  AvailableBookingCubit(this.repository) : super(AvailableBookingInitial());

  Future<void> getAvailableBookings({
    required String date,
    required int clinicId,
    required int doctorId,
  }) async {
    emit(AvailableBookingLoading());

    final response = await repository.getAvailableBookings(
      date: date,
      clinicId: clinicId,
      doctorId: doctorId,
    );

    response.fold(
      (error) => emit(AvailableBookingFailure(error)),
      (model) {
        // Show the first available day's slots (e.g., Monday)
        final firstDay = model.bookings.entries.firstWhere(
          (entry) => entry.value.isNotEmpty,
          orElse: () => const MapEntry('N/A', []),
        );
        emit(AvailableBookingSuccess(
          data: model.bookings,
          currentDay: firstDay.key,
          currentSlots: firstDay.value,
        ));
      },
    );
  }
}
