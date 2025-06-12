import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/models/patient_profile_model.dart';
import 'package:skintelligent/models/sumarize_model.dart';
import 'package:skintelligent/models/update_patient_profile_model.dart';
import 'package:skintelligent/models/user_appointment_cancel_model.dart';
import 'package:skintelligent/models/available_booking_model.dart';
import 'package:skintelligent/models/doctor_model.dart';
import 'package:skintelligent/models/get_review_model.dart';
import 'package:skintelligent/models/make_review_model.dart';
import 'package:skintelligent/models/user_booking_model.dart';
import '../../models/appointment_model.dart';
import '../../models/chat_model.dart';
import '../../models/forget_model.dart';
import '../../models/reset_model.dart';
import 'package:http_parser/http_parser.dart'; // for Media

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
      await getIt<CacheHelper>()
          .saveData(key: ApiKey.Authorization, value: user.token);
      // Decode the token to extract patient ID

      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
    required String dateOfBirth,
    required String gender,
    required String imagePath,
  }) async {
    try {
      // Read the image file as bytes
      final bytes = await File(imagePath).readAsBytes();

      // Create MultipartFile from bytes
      final multipartFile = MultipartFile.fromBytes(
        bytes,
        filename: 'profile.jpg',
        contentType: MediaType('image', 'jpeg'),
      );

      // Create FormData
      final formData = FormData.fromMap({
        'FirstName': firstName,
        'LastName': lastName,
        'Address': address,
        'Phone': phone,
        'Email': email,
        'Password': password,
        'ConfirmPassword': confirmPassword,
        'DateOfBirth': dateOfBirth,
        'Gender': gender,
        'ProfilePicture': multipartFile,
      });

      // Send request
      final response = await Dio().post(
        'http://skintelligent.runasp.net/api/auth/patient/register',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print("✅ Response: ${response.data}");
    } catch (e) {
      if (e is DioException) {
        print("❗ Dio Error:");
        print("Status: ${e.response?.statusCode}");
        print("Data: ${e.response?.data}");
      } else {
        print("❗ Unknown Error: $e");
      }
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final id = await getIt<CacheHelper>().getData(key: ApiKey.id);
      final response = await api.get(Endpoint.getUserDataEndPoint(id));
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, AppointmentModel>> getAllDoctors() async {
    try {
      final response = await api.get(Endpoint.getDoctors);
      return Right(AppointmentModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DoctorModel>> getDoctorProfile(int doctorID) async {
    try {
      final response = await api.get(Endpoint.doctorById(doctorID));
      if (response is List && response.isNotEmpty) {
        return Right(DoctorModel.fromJson(response.first));
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
      final response = await api.get(
        Endpoint.getReviews(doctorID),
        queryParameters: {
          ApiKey.pageSize: pageSize,
        },
      );
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
        data: {
          ApiKey.email: email,
        },
      );
      return Right(ForgetModel.fromJson(response));
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
        data: {
          ApiKey.email: email,
          ApiKey.password: password,
          ApiKey.resetOTP: resetOTP,
        },
      );
      return Right(ResetModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, ResetModel>> newUser({
    required String email,
    required String otpCode,
  }) async {
    try {
      final response = await api.post(
        Endpoint.newUser,
        data: {
          ApiKey.email: email,
          ApiKey.codeOTP: otpCode,
        },
      );
      return Right(ResetModel.fromJson(response));
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
      return Right(WeeklySchedule.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, WeeklySchedule>> makeBooking({
    required int appointmentId,
  }) async {
    try {
      final response = await api.post(
        Endpoint.makeBooking,
        queryParameters: {
          ApiKey.appointmentId: appointmentId,
        },
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

  Future<Either<String, ChatModel>> sendConversation(dynamic messages,int appointmentID,int patientID) async {
    try {
      final messageContent = messages[0]['content'];
      print("Sending message to API: $messageContent");

      final response = await api.post(
        Endpoint.chats,
        data: {
          "appointmentId": appointmentID,
          "message": messageContent,
          "patinetId": patientID,
        },
      );

      print("API response: $response");
      return Right(ChatModel.fromJson(response));
    } on ServerException catch (e) {
      print("API error: ${e.errorModel.errorMessage}");
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, PatientProfileModel>> getPatientProfile(
      int userID) async {
    try {
      final response = await api.get(
        Endpoint.getUserProfile(userID),
      );
      return Right(PatientProfileModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UpdatePatientProfileModel>> updatePatientProfile({
    required int id,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
    required String dateOfBirth,
    required String profilePicture,
  }) async {
    try {
      final bytes = await File(profilePicture).readAsBytes();

      // Create MultipartFile from bytes
      final multipartFile = MultipartFile.fromBytes(
        bytes,
        filename: 'profile.jpg',
        contentType: MediaType('image', 'jpeg'),
      );
      final response = await api.put(
        isFormData: true,
        Endpoint.updatePatientProfile(),
        data: {
          'Id ': id,
          'FirstName': firstName,
          'LastName': lastName,
          'Address': address,
          'Phone': phone,
          'DateOfBirth': dateOfBirth,
          'ProfilePicture': multipartFile
        },
      );
      return Right(UpdatePatientProfileModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
