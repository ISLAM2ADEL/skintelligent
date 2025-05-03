import 'package:skintelligent/commons.dart';

class UserBookingModel {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  bool isCanceled;
  final String doctorName;
  final String clinicName;
  final String clinicAddress;

  UserBookingModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isCanceled,
    required this.doctorName,
    required this.clinicName,
    required this.clinicAddress,
  });

  factory UserBookingModel.fromJson(Map<String, dynamic> json) {
    return UserBookingModel(
      id: json[ApiKey.id],
      startTime: DateTime.parse(json[ApiKey.startTime]),
      endTime: DateTime.parse(json[ApiKey.endTime]),
      isCanceled: json[ApiKey.isCanceled],
      doctorName: json[ApiKey.doctorName],
      clinicName: json[ApiKey.clinicName],
      clinicAddress: json[ApiKey.clinicAddress],
    );
  }
}
