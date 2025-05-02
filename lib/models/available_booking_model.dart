import 'package:skintelligent/controllers/api/endpoint.dart';

class AppointmentSlot {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCanceled;
  final bool isBooked;
  final DateTime repeatUntil;

  AppointmentSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isCanceled,
    required this.isBooked,
    required this.repeatUntil,
  });

  factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
    return AppointmentSlot(
      id: json[ApiKey.id],
      startTime: DateTime.parse(json[ApiKey.startTime]),
      endTime: DateTime.parse(json[ApiKey.endTime]),
      isCanceled: json[ApiKey.isCanceled],
      isBooked: json[ApiKey.isBooked],
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

// ----------------------
class Session {
  final int id;
  final String startTime;
  final String endTime;
  final bool isCanceled;
  final bool isBooked;
  final String repeatUntil;

  Session({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isCanceled,
    required this.isBooked,
    required this.repeatUntil,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isCanceled: json['isCanceled'],
      isBooked: json['isBooked'],
      repeatUntil: json['repeatUntil'],
    );
  }
}



class WeeklySchedule {
  final List<Session> sunday;
  final List<Session> monday;
  final List<Session> tuesday;
  final List<Session> wednesday;
  final List<Session> thursday;
  final List<Session> friday;
  final List<Session> saturday;

  WeeklySchedule({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  factory WeeklySchedule.fromJson(Map<String, dynamic> json) {
    return WeeklySchedule(
      sunday: (json['Sunday'] as List).map((e) => Session.fromJson(e)).toList(),
      monday: (json['Monday'] as List).map((e) => Session.fromJson(e)).toList(),
      tuesday: (json['Tuesday'] as List).map((e) => Session.fromJson(e)).toList(),
      wednesday: (json['Wednesday'] as List).map((e) => Session.fromJson(e)).toList(),
      thursday: (json['Thursday'] as List).map((e) => Session.fromJson(e)).toList(),
      friday: (json['Friday'] as List).map((e) => Session.fromJson(e)).toList(),
      saturday: (json['Saturday'] as List).map((e) => Session.fromJson(e)).toList(),
    );
  }
}
