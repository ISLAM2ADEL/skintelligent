import 'package:skintelligent/controllers/api/endpoint.dart';

class UserAppointmentCancelModel {
  final String message;
  final int statusCode;
  const UserAppointmentCancelModel({
    required this.message,
    required this.statusCode,
  });
  factory UserAppointmentCancelModel.fromJson(Map<String, dynamic> json) {
    return UserAppointmentCancelModel(
      message: json[ApiKey.message] as String,
      statusCode: json[ApiKey.statusCode] as int,
    );
  }
}
