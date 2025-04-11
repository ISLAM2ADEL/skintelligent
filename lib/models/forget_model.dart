import 'package:skintelligent/commons.dart';

class ForgetModel {
  final String message;
  final Data data;

  ForgetModel({required this.message, required this.data});
  factory ForgetModel.fromJson(Map<String, dynamic> json) {
    return ForgetModel(
      message: json[ApiKey.message],
      data: Data.fromJson(json[ApiKey.data]),
    );
  }
}

class Data {
  final String email;
  Data({
    required this.email,
  });

  factory Data.fromJson(json) {
    return Data(
      email: json[ApiKey.email],
    );
  }
}
