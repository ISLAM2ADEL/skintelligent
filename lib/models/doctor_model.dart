import '../controllers/api/endpoint.dart';
import 'clinic_model.dart';

class DoctorModel {
  final int id;
  final String firstName;
  final String lastName;
  final int experienceYears;
  final String profilePicture;
  final bool isApproved;
  final List<ClinicModel> clinics;
  final DateTime dateOfBirth;
  final String gender;
  final String licenseNumber;
  final String phoneNumber;
  final int defaultExaminationFee;
  final int defaultConsultationFee;
  final String aboutMe;
  final String qualification;
  final DateTime createdDate;
  final DateTime updatedDate;
  final String email;

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
    required this.gender,
    required this.licenseNumber,
    required this.phoneNumber,
    required this.aboutMe,
    required this.qualification,
    required this.email,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json[ApiKey.gender] ?? '',
        licenseNumber : json[ApiKey.licenseNumber] ?? '',
        dateOfBirth : DateTime.parse(json[ApiKey.dateOfBirth]),
        experienceYears : (json[ApiKey.experienceYears] as num?)?.toInt() ?? 0,
        phoneNumber : json[ApiKey.phone] ?? '',
        defaultExaminationFee :
            (json[ApiKey.defaultExaminationFee] as num?)?.toInt() ?? 0,
        defaultConsultationFee :
            (json[ApiKey.defaultConsultationFee] as num?)?.toInt() ?? 0,
        profilePicture : json[ApiKey.profilePic] ?? '',
        aboutMe : json[ApiKey.aboutMe] ?? '',
        qualification : json[ApiKey.qualification] ?? '',
        isApproved : json[ApiKey.isApproved] ?? false,
        createdDate : DateTime.parse(json[ApiKey.createdDate]),
        updatedDate : DateTime.parse(json[ApiKey.updatedDate]),
        email : json[ApiKey.email] ?? '',
      clinics: (json['clinics'] as List<dynamic>?)
          ?.map((e) => ClinicModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}
