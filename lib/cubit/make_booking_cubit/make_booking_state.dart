import 'package:skintelligent/models/available_booking_model.dart';

class MakeBookginState {}

final class BookingInitial extends MakeBookginState {}

final class BookingLoading extends MakeBookginState {}

final class BookingSuccess extends MakeBookginState {
  final WeeklySchedule booking;

  BookingSuccess({required this.booking});
}

final class BookingFailure extends MakeBookginState {
  final String errMessage;

  BookingFailure({required this.errMessage});
}
