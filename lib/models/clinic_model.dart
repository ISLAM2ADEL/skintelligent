class ClinicModel {
  final int id;
  final String clinicName;
  final String address;
  final String createdDate;

  ClinicModel({
    required this.id,
    required this.clinicName,
    required this.address,
    required this.createdDate,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      id: json['id'] ?? 0,
      clinicName: json['clinicName'] ?? '',
      address: json['address'] ?? '',
      createdDate: json['createdDate'] ?? '',
    );
  }
}
