import 'package:skintelligent/models/available_booking_model.dart';

abstract class AvailableBookingState {}

class AvailableBookingInitial extends AvailableBookingState {}

class AvailableBookingLoading extends AvailableBookingState {}

class AvailableBookingFailure extends AvailableBookingState {
  final String message;
  AvailableBookingFailure(this.message);
}

class AvailableBookingSuccess extends AvailableBookingState {
  final Map<String, List<Session>> data;
  final String currentDay;
  final List<Session> currentSlots;

  AvailableBookingSuccess({
    required this.data,
    required this.currentDay,
    required this.currentSlots,
  });
}
