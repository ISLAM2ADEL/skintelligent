import 'package:skintelligent/controllers/api/endpoint.dart';

class AppointmentSlot {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCanceled;
  final bool isRepeating;
  final int repeatDay;
  final DateTime repeatUntil;

  AppointmentSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isCanceled,
    required this.isRepeating,
    required this.repeatDay,
    required this.repeatUntil,
  });

  factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
    return AppointmentSlot(
      id: json[ApiKey.id],
      startTime: DateTime.parse(json[ApiKey.startTime]),
      endTime: DateTime.parse(json[ApiKey.endTime]),
      isCanceled: json[ApiKey.isCanceled],
      isRepeating: json[ApiKey.isRepeating],
      repeatDay: json[ApiKey.repeatDay],
      repeatUntil: DateTime.parse(json[ApiKey.repeatUntil]),
    );
  }
}

class AvailableBookingModel {
  final Map<String, List<AppointmentSlot>> bookings;

  AvailableBookingModel({required this.bookings});

  factory AvailableBookingModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<AppointmentSlot>> parsed = {};

    json.forEach((day, slotsJson) {
      parsed[day] = (slotsJson as List)
          .map((slotJson) => AppointmentSlot.fromJson(slotJson))
          .toList();
    });

    return AvailableBookingModel(bookings: parsed);
  }
}
