import 'package:skintelligent/models/user_booking_model.dart';

abstract class UserBookingState {}

class UserBookingInitial extends UserBookingState {}

class UserBookingLoading extends UserBookingState {}

class UserBookingFailure extends UserBookingState {
  final String message;

  UserBookingFailure(this.message);
}

class UserBookingSuccess extends UserBookingState {
  final List<UserBookingModel> bookings;

  UserBookingSuccess(this.bookings);
}
