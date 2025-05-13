class ForgetModel {
  final String message;
  final int? statusCode; // Nullable to prevent crash
  ForgetModel({
    required this.message,
    this.statusCode, // Make it nullable
  });

  factory ForgetModel.fromJson(Map<String, dynamic> json) {
    return ForgetModel(
        statusCode: json["statusCode"],
        message: json["message"] ?? "No message");
  }
}
