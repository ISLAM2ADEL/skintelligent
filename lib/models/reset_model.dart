class ResetModel {
  final String message;
  final int? statusCode; // Nullable to prevent crash
  ResetModel({
    required this.message,
    this.statusCode, // Make it nullable
  });

  factory ResetModel.fromJson(Map<String, dynamic> json) {
    return ResetModel(
        statusCode: json["statusCode"],
        message: json["message"] ?? "No message");
  }
}
