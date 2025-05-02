import 'package:skintelligent/controllers/api/endpoint.dart';

class MakeReviewModel {
  final String message;
 final  int statusCode;

  MakeReviewModel({required this.message, required this.statusCode}); 
  factory MakeReviewModel.fromJson(Map<String, dynamic> json) {
    return MakeReviewModel(
      message: json[ApiKey.message],
      statusCode: json[ApiKey.status],
    );
  }

}
