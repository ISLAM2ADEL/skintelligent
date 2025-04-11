import 'package:skintelligent/commons.dart';
class UserModel {
  final String profilePic;
  final String name;
  final String email;
  final String phone;
  final Map<String, dynamic> location;

  UserModel(
      {required this.profilePic,
      required this.name,
      required this.email,
      required this.phone,
      required this.location});
  factory UserModel.fromJson(json) {
    return UserModel(
      location: json['user'][ApiKey.location],
      profilePic: json['user'][ApiKey.profilePic] ?? "",
      name: json['user'][ApiKey.name],
      email: json['user'][ApiKey.email],
      phone: json['user'][ApiKey.phone],
    );
  }
}
