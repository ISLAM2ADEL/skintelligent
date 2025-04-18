// lib/features/doctor/data/models/doctor_model.dart

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
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      licenseNumber: json['licenseNumber'],
      experienceYears: json['experienceYears'],
      phoneNumber: json['phoneNumber'],
      defaultExaminationFee: json['defaultExaminationFee'],
      defaultConsultationFee: json['defaultConsultationFee'],
      profilePicture: json['profilePicture'],
      aboutMe: json['aboutMe'],
      qualification: json['qualification'],
      isApproved: json['isApproved'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
      email: json['email'],
    );
  }


}
