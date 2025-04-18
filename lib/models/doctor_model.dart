class DoctorModel {
  final int id;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String licenseNumber;
  final int experienceYears;
  final String phoneNumber; // ✅ مضافة جديد
  final double defaultExaminationFee;
  final double defaultConsultationFee;
  final String profilePicture;
  final String qualification;
  final bool isApproved;
  final String createdDate;
  final String updatedDate;
  final String email;
  final String? aboutMe;

  DoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.licenseNumber,
    required this.experienceYears,
    required this.phoneNumber, // ✅
    required this.defaultExaminationFee,
    required this.defaultConsultationFee,
    required this.profilePicture,
    required this.qualification,
    required this.isApproved,
    required this.createdDate,
    required this.updatedDate,
    required this.email,
    this.aboutMe,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      phoneNumber: json['phoneNumber'] ?? '', // ✅
      defaultExaminationFee: (json['defaultExaminationFee'] as num?)?.toDouble() ?? 0.0,
      defaultConsultationFee: (json['defaultConsultationFee'] as num?)?.toDouble() ?? 0.0,
      profilePicture: json['profilePicture'] ?? '',
      qualification: json['qualification'] ?? '',
      isApproved: json['isApproved'] ?? false,
      createdDate: json['createdDate'] ?? '',
      updatedDate: json['updatedDate'] ?? '',
      email: json['email'] ?? '',
      aboutMe: json['aboutMe'],
    );
  }
}
