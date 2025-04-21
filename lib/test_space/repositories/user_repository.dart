import 'package:dio/dio.dart';
import '../models/sign_up_model.dart';

class UserRepository {
  final Dio dio;

  UserRepository({required this.dio});

  Future<SignUpModel> signUp(Map<String, dynamic> patientData) async {
    final response = await dio.post(
      'http://skintelligent.runasp.net/api/auth/register?registerType=patient',
      data: {'patient': patientData},
    );
    return SignUpModel.fromJson(response.data);
  }
}