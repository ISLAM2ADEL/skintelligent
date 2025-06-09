import 'package:skintelligent/controllers/api/endpoint.dart';

class PatientProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String address;
  final String profilePicture;
  final DateTime createdDate;
  final DateTime updatedDate;
  final String email;
  final String phone;

  PatientProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.profilePicture,
    required this.createdDate,
    required this.updatedDate,
    required this.email,
    required this.phone,
  });

  factory PatientProfileModel.fromJson(Map<String, dynamic> json) {
    return PatientProfileModel(
      id: json[ApiKey.id],
      firstName: json[ApiKey.firstName]?.toString() ?? '',
      lastName: json[ApiKey.lastName]?.toString() ?? '',
      dateOfBirth:
          DateTime.tryParse(json[ApiKey.dateOfBirth] ?? '') ?? DateTime(2000),
      gender: json[ApiKey.gender]?.toString() ?? '',
      address: json[ApiKey.address]?.toString() ?? '',
      profilePicture: json[ApiKey.profilePicture]?.toString() ?? '',
      createdDate:
          DateTime.tryParse(json[ApiKey.createdDate] ?? '') ?? DateTime(2000),
      updatedDate:
          DateTime.tryParse(json[ApiKey.updatedDate] ?? '') ?? DateTime(2000),
      email: json[ApiKey.email]?.toString() ?? '',
      phone: json[ApiKey.phone]?.toString() ?? '',
    );
  }
}
