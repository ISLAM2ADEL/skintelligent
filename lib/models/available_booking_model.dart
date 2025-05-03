import 'package:skintelligent/controllers/api/endpoint.dart';

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
      id: json[ApiKey.id],
      startTime: json[ApiKey.startTime],
      endTime: json[ApiKey.endTime],
      isCanceled: json[ApiKey.isCanceled],
      isBooked: json[ApiKey.isBooked],
      repeatUntil: json[ApiKey.repeatUntil],
    );
  }
}

class WeeklySchedule {
  final List<Session> Sunday;
  final List<Session> Monday;
  final List<Session> Tuesday;
  final List<Session> Wednesday;
  final List<Session> Thursday;
  final List<Session> Friday;
  final List<Session> Saturday;

  WeeklySchedule({
    required this.Sunday,
    required this.Monday,
    required this.Tuesday,
    required this.Wednesday,
    required this.Thursday,
    required this.Friday,
    required this.Saturday,
  });

  factory WeeklySchedule.fromJson(Map<String, dynamic> json) {
    return WeeklySchedule(
      Sunday: (json['Sunday'] ?? [])
          .map<Session>((e) => Session.fromJson(e))
          .toList(),
      Monday: (json['Monday'] ?? [])
          .map<Session>((e) => Session.fromJson(e))
          .toList(),
      Tuesday: (json['Tuesday'] ?? [])
          .map<Session>((e) => Session.fromJson(e))
          .toList(),
      Wednesday: (json['Wednesday'] ?? [])
          .map<Session>((e) => Session.fromJson(e))
          .toList(),
      Thursday: (json['Thursday'] ?? [])
          .map<Session>((e) => Session.fromJson(e))
          .toList(),
      Friday: (json['Friday'] ?? [])
          .map<Session>((e) => Session.fromJson(e))
          .toList(),
      Saturday: (json['Saturday'] ?? [])
          .map<Session>((e) => Session.fromJson(e))
          .toList(),
    );
  }
}
