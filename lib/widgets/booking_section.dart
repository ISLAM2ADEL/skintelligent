import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/models/available_booking_model.dart';
import 'package:skintelligent/widgets/available_booking.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_state.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_cubit.dart';

class BookingSection extends StatelessWidget {
  final Map<String, List<Session>>? cachedWeeklySlots;
  final Function(Map<String, List<Session>> data) onCacheUpdate;

  const BookingSection({
    super.key,
    required this.cachedWeeklySlots,
    required this.onCacheUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableBookingCubit, AvailableBookingState>(
      builder: (context, state) {
        if (state is AvailableBookingLoading && cachedWeeklySlots == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AvailableBookingFailure) {
          return Text("Failed to load: ${state.message}");
        } else if (state is AvailableBookingSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onCacheUpdate(state.data);
          });
          return AvailableBooking(allSlots: state.data);
        } else if (cachedWeeklySlots != null) {
          return AvailableBooking(allSlots: cachedWeeklySlots!);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
