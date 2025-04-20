import 'package:skintelligent/models/available_booking_model.dart';

class BookingStore {
  static final BookingStore _instance = BookingStore._internal();
  factory BookingStore() => _instance;
  BookingStore._internal();

  final Set<AppointmentSlot> selectedSlots = {};
}
