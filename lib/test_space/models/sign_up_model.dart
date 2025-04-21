class SignUpModel {
  final String message;
  final int statusCode;

  SignUpModel({required this.message, required this.statusCode});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}