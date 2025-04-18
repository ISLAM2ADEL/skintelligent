// lib/cubit/available_booking_cubit/available_booking_state.dart

import 'package:skintelligent/models/available_booking_model.dart';

abstract class AvailableBookingState {}

class AvailableBookingInitial extends AvailableBookingState {}

class AvailableBookingLoading extends AvailableBookingState {}

class AvailableBookingFailure extends AvailableBookingState {
  final String message;
  AvailableBookingFailure(this.message);
}

class AvailableBookingSuccess extends AvailableBookingState {
  final Map<String, List<AppointmentSlot>> data;
  final String currentDay;
  final List<AppointmentSlot> currentSlots;

  AvailableBookingSuccess({
    required this.data,
    required this.currentDay,
    required this.currentSlots,
  });
}
