import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/api/api_consumer.dart';
import 'package:skintelligent/models/forget_model.dart';
import 'package:skintelligent/models/signup_model.dart';

import '../../models/appointment_model.dart';
import '../../models/reset_model.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});
  Future<Either<String, SigninModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        Endpoint.signIn,
        data: {
          ApiKey.email: email,
          ApiKey.password: password,
        },
      );
      final user = SigninModel.fromJson(response);
      // final decodedToken = JwtDecoder.decode(user.token);
      await getIt<CacheHelper>().saveData(key: ApiKey.token, value: user.token);
      // await getIt<CacheHelper>().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, ForgetModel>> forgetPassword({
    required String email,
  }) async {
    try {
      final response = await api.post(
        Endpoint.forgetPassword,
        isFormData: false,
        data: {
          ApiKey.email: email,
        },
      );
      print(response);
      final forgetModel = ForgetModel.fromJson(response);
      return Right(forgetModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, ResetModel>> resetPassword({
    required String email,
    required String password,
    required String resetOTP,
  }) async {
    try {
      final response = await api.post(
        Endpoint.resetPassword,
        isFormData: false,
        data: {
          ApiKey.email: email,
          ApiKey.password: password,
          ApiKey.resetOTP: resetOTP,
        },
      );
      print(response);
      final resetModel = ResetModel.fromJson(response);
      return Right(resetModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignupModel>> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
    required XFile profilePic,
  }) async {
    try {
      final response = await api.post(
        Endpoint.signUp,
        isFormData: true,
        data: {
          ApiKey.name: name,
          ApiKey.phone: phone,
          ApiKey.email: email,
          ApiKey.password: password,
          ApiKey.confirmPassword: confirmPassword,
          ApiKey.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKey.profilePic: await uploadImageToApi(profilePic)
        },
      );
      print(response);
      final signUPModel = SignupModel.fromJson(response);
      return Right(signUPModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(
        Endpoint.getUserDataEndPoint(
          await getIt<CacheHelper>().getData(key: ApiKey.id),
        ),
      );
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, AppointmentModel>> getAllDoctors() async {
    try {
      final response = await api.get(
        Endpoint.getDoctors,
        queryParameters: {},
      );
      print(response);

      final appointmentModel = AppointmentModel.fromJson(response);
      return Right(appointmentModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
