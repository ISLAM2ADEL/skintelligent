import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/models/sumarize_model.dart';
import 'package:skintelligent/models/user_appointment_cancel_model.dart';
import 'package:skintelligent/models/available_booking_model.dart';
import 'package:skintelligent/models/doctor_model.dart';
import 'package:skintelligent/models/get_review_model.dart';
import 'package:skintelligent/models/make_review_model.dart';
import 'package:skintelligent/models/signup_model.dart';
import 'package:skintelligent/models/user_booking_model.dart';
import '../../models/appointment_model.dart';
import '../../models/forget_model.dart';
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
      await getIt<CacheHelper>()
          .saveData(key: ApiKey.Authorization, value: user.token);
      // await getIt<CacheHelper>().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignupModel>> signUp({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String gender,
    required String phone,
    required String email,
    required String password,
    required String address,
    required String confirmPassword,
    required MultipartFile profilePic,
  }) async {
    try {
      final formData = FormData.fromMap({
        'Patient.Email': email,
        'Patient.Phone': phone,
        'Patient.Password': password,
        'Patient.ConfirmPassword': confirmPassword,
        'Patient.FirstName': firstName,
        'Patient.LastName': lastName,
        'Patient.DateOfBirth': dateOfBirth,
        'Patient.Gender': gender,
        'Patient.Address': address,
        'Patient.ProfilePicture': profilePic, // Use the existing MultipartFile
      });

      final response = await api.post(
        Endpoint.signUp,
        data: formData,
        isFormData: true,
        queryParameters: {'registerType': 'patient'},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${getIt<CacheHelper>().getData(key: ApiKey.Authorization)}',
          },
        ),
      );

      return Right(SignupModel.fromJson(response));
    } on DioException catch (e) {
      print('Upload Error: ${e.response?.data}');
      return Left(e.response?.data?['message'] ?? 'Failed to upload image');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
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
      final response = await api.get(Endpoint.getDoctors,
      );
      final model = AppointmentModel.fromJson(response);
      return Right(model);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DoctorModel>> getDoctorProfile(int doctorID) async {
    try {
      final response = await api.get(Endpoint.doctorById(doctorID));

      if (response is List && response.isNotEmpty) {
        final doctorData = response.first as Map<String, dynamic>;
        return Right(DoctorModel.fromJson(doctorData));
      } else {
        return Left('Doctor not found.');
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, GetReviewModel>> getReviews(
      int doctorID, int pageSize) async {
    try {
      final response =
          await api.get(Endpoint.getReviews(doctorID), queryParameters: {
        ApiKey.pageSize: pageSize,
      });
      return Right(GetReviewModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, MakeReviewModel>> makeReview({
    required int clinicID,
    required int doctorID,
    required String comment,
    required int rating,
  }) async {
    try {
      final response = await api.post(
        Endpoint.makeReviews(),
        data: {
          ApiKey.clinictId: clinicID,
          ApiKey.doctorId: doctorID,
          ApiKey.comment: comment,
          ApiKey.rating: rating,
        },
      );
      return Right(MakeReviewModel.fromJson(response));
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

  Future<Either<String, WeeklySchedule>> getAvailableBookings({
    required String date,
    required int clinicId,
    required int doctorId,
  }) async {
    try {
      final response = await api.get(
        Endpoint.appointmentByWeek,
        queryParameters: {
          "date": date,
          "clinicId": clinicId,
          "doctorId": doctorId,
        },
      );
      final schedule = WeeklySchedule.fromJson(response);
      return Right(schedule);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, WeeklySchedule>> makeBooking({
    required int appointmentId,
  }) async {
    try {
      final response = await api.post(
        queryParameters: {
          ApiKey.appointmentId: appointmentId,
        },
        Endpoint.makeBooking,
      );
      return Right(WeeklySchedule.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, List<UserBookingModel>>> getMyBookings() async {
    try {
      final response = await api.get(Endpoint.userBookingAppointments);
      final bookings =
          (response as List).map((e) => UserBookingModel.fromJson(e)).toList();
      return Right(bookings);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserAppointmentCancelModel>> cancelBooking({
    required int appointmentId,
  }) async {
    try {
      final response = await api.put(
        Endpoint.cancelBooking(appointmentid: appointmentId),
        data: {
          ApiKey.appointmentId: appointmentId,
        },
      );
      return Right(UserAppointmentCancelModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SummarizeModelResponse>> summarize(
      dynamic messages) async {
    try {
      final response =
          await api.post(Endpoint.getSummary, data: {"messages": messages});
      return Right(SummarizeModelResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
