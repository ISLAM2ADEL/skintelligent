import 'package:skintelligent/commons.dart';

class UpdatePatientProfileModel {
  final ErrorModel error;
  final String message;
  final String statusCode;

  UpdatePatientProfileModel(
      {required this.error, required this.message, required this.statusCode});
  factory UpdatePatientProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdatePatientProfileModel(
      error: ErrorModel.fromJson(json[ApiKey.errors] ?? {}),
      message: json[ApiKey.message] ?? '',
      statusCode: json[ApiKey.statusCode]?.toString() ?? '',
    );
  }
}

class ErrorModel {
  final List<String> ProfilePicture;

  ErrorModel({required this.ProfilePicture});
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      ProfilePicture: List<String>.from(json['ProfilePicture'] ?? []),
    );
  }
}
