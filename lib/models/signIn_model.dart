import 'package:skintelligent/commons.dart';

class SigninModel {
  final String message;
  final Data data;

  SigninModel({required this.message, required this.data});
  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(
      message: json[ApiKey.message],
      data: Data.fromJson(json[ApiKey.data]),
    );
  }
}

class Data {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final num points;
  final num credit;
  final String token;

  Data(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.image,
      required this.points,
      required this.credit,
      required this.token});

  factory Data.fromJson(json) {
    return Data(
      id: json[ApiKey.id],
      name: json[ApiKey.name],
      email: json[ApiKey.email],
      phone: json[ApiKey.phone],
      image: json[ApiKey.image],
      points: json[ApiKey.points],
      credit: json[ApiKey.credit],
      token: json[ApiKey.token],
    );
  }
}
