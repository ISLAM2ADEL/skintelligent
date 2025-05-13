import 'doctor_model.dart';

class AppointmentModel {
  final int pageIndex;
  final int pageSize;
  final int count;
  final List<DoctorModel> doctors;
  final String message;

  AppointmentModel({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.doctors,
    required this.message,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      pageIndex: json['pageIndex'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      count: json['count'] ?? 0,
      message: json['message'] ?? 'No message',
      doctors: (json['data'] as List<dynamic>?)?.map((e) => DoctorModel.fromJson(e)).toList() ?? [],
    );
  }
}