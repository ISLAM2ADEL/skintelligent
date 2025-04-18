class AppointmentModel {
  final int id;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String licenseNumber;
  final int experienceYears;
  final double defaultExaminationFee;
  final double defaultConsultationFee;
  final String profilePicture;
  final String qualification;
  final bool isApproved;
  final String createdDate;
  final String updatedDate;
  final String email;
  final int? statusCode;
  final String message;

  AppointmentModel({
    required this.message,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.licenseNumber,
    required this.experienceYears,
    required this.defaultExaminationFee,
    required this.defaultConsultationFee,
    required this.profilePicture,
    required this.qualification,
    required this.isApproved,
    required this.createdDate,
    required this.updatedDate,
    required this.email,
    this.statusCode, // Make it nullable
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
        statusCode: json["statusCode"],
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        dateOfBirth: json['dateOfBirth'],
        gender: json['gender'],
        licenseNumber: json['licenseNumber'],
        experienceYears: json['experienceYears'],
        defaultExaminationFee:
            (json['defaultExaminationFee'] as num).toDouble(),
        defaultConsultationFee:
            (json['defaultConsultationFee'] as num).toDouble(),
        profilePicture: json['profilePicture'],
        qualification: json['qualification'],
        isApproved: json['isApproved'],
        createdDate: json['createdDate'],
        updatedDate: json['updatedDate'],
        email: json['email'],
        message: json["message"] ?? "No message");
  }
}
