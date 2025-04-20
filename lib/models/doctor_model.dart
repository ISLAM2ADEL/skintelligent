import 'clinic_model.dart';

class DoctorModel {
  final int id;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final int experienceYears;
  final double defaultExaminationFee;
  final double defaultConsultationFee;
  final String profilePicture;
  final bool isApproved;
  final String createdDate;
  final String updatedDate;
  final List<ClinicModel> clinics;

  DoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.experienceYears,
    required this.defaultExaminationFee,
    required this.defaultConsultationFee,
    required this.profilePicture,
    required this.isApproved,
    required this.createdDate,
    required this.updatedDate,
    required this.clinics,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      defaultExaminationFee: (json['defaultExaminationFee'] as num?)?.toDouble() ?? 0.0,
      defaultConsultationFee: (json['defaultConsultationFee'] as num?)?.toDouble() ?? 0.0,
      profilePicture: json['profilePicture'] ?? '',
      isApproved: json['isApproved'] ?? false,
      createdDate: json['createdDate'] ?? '',
      updatedDate: json['updatedDate'] ?? '',
      clinics: (json['clinics'] as List<dynamic>?)
          ?.map((e) => ClinicModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}
