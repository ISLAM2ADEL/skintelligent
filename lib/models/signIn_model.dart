class SigninModel {
  final String message;
  final int? statusCode; // Nullable to prevent crash
  final String refreshToken;
  final String expiration;
  final String token;

  SigninModel({
    required this.message,
    this.statusCode, // Make it nullable
    required this.refreshToken,
    required this.expiration,
    required this.token,
  });

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(
        statusCode: json["statusCode"],
        refreshToken: json["refreshToken"] ?? "", // Ensure it's never null
        expiration: json["expiration"] ?? "",
        message: json["message"] ?? "No message",
        token: json["token"]);
  }
}
