// lib/features/doctor/data/models/doctor_model.dart

import 'package:skintelligent/controllers/api/endpoint.dart';

class DoctorModel {
  final int id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String licenseNumber;
  final int experienceYears;
  final String phoneNumber;
  final int defaultExaminationFee;
  final int defaultConsultationFee;
  final String profilePicture;
  final String aboutMe;
  final String qualification;
  final bool isApproved;
  final DateTime createdDate;
  final DateTime updatedDate;
  final String email;

  DoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.licenseNumber,
    required this.experienceYears,
    required this.phoneNumber,
    required this.defaultExaminationFee,
    required this.defaultConsultationFee,
    required this.profilePicture,
    required this.aboutMe,
    required this.qualification,
    required this.isApproved,
    required this.createdDate,
    required this.updatedDate,
    required this.email,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json[ApiKey.id],
      firstName: json[ApiKey.firstName],
      lastName: json[ApiKey.lastName],
      dateOfBirth: DateTime.parse(json[ApiKey.dateOfBirth]),
      gender: json[ApiKey.gender],
      licenseNumber: json[ApiKey.licenseNumber],
      experienceYears: (json[ApiKey.experienceYears] as num).toInt(),
      phoneNumber: json[ApiKey.phone],
      defaultExaminationFee:
          (json[ApiKey.defaultExaminationFee] as num).toInt(),
      defaultConsultationFee:
          (json[ApiKey.defaultConsultationFee] as num).toInt(),
      profilePicture: json[ApiKey.profilePic],
      aboutMe: json[ApiKey.aboutMe],
      qualification: json[ApiKey.qualification],
      isApproved: json[ApiKey.isApproved],
      createdDate: DateTime.parse(json[ApiKey.createdDate]),
      updatedDate: DateTime.parse(json[ApiKey.updatedDate]),
      email: json[ApiKey.email],
    );
  }
}
