import 'package:skintelligent/commons.dart';

class ErrorModel {
  final bool status;
  final String errorMessage;
  final dynamic data;
  ErrorModel(
      {required this.status, required this.errorMessage, required this.data});
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        status: json[ApiKey.status],
        errorMessage: json[ApiKey.errorMessage],
        data: json[ApiKey.data]);
  }
}
