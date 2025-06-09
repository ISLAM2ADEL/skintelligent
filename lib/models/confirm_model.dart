class ConfirmModel {
  final String message;

  ConfirmModel({required this.message});

  factory ConfirmModel.fromJson(Map<String, dynamic> json) {
    return ConfirmModel(
      message: json['message'] ?? '',
    );
  }
}
