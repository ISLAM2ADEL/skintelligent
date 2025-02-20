import 'package:skintelligent/commons.dart';
class SignupModel {
  final String message;
  SignupModel({required this.message});
  factory SignupModel.fromJson(json) {
    return SignupModel(
      message: json[ApiKey.message],
    );
  }
}
