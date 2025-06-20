
import 'package:flutter_bloc/flutter_bloc.dart';
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
      (schedule) {
        // نختار أول يوم فيه جلسات متاحة
        final dayMap = {
          'Sunday': schedule.Sunday,
          'Monday': schedule.Monday,
          'Tuesday': schedule.Tuesday,
          'Wednesday': schedule.Wednesday,
          'Thursday': schedule.Thursday,
          'Friday': schedule.Friday,
          'Saturday': schedule.Saturday,
        };

        final firstAvailableDay = dayMap.entries.firstWhere(
          (entry) => entry.value.isNotEmpty,
          orElse: () => const MapEntry('N/A', []),
        );

        emit(AvailableBookingSuccess(
          data: dayMap,
          currentDay: firstAvailableDay.key,
          currentSlots: firstAvailableDay.value,
        ));
      },
    );
  }
}
