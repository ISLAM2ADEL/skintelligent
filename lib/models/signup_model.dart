import 'package:skintelligent/controllers/api/endpoint.dart';

class SignupModel {
  final String message;
  SignupModel({required this.message});
  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      message: json[ApiKey.message],
    );
  }
}
