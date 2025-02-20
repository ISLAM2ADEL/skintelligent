import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {
  Dio dio;
  Api(this.dio);
  Future<Response> get({required String url, @required String? token}) async {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    try {
      Response response =
          await dio.get(url, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.statusCode.toString() ?? "unknown error ";

      throw Exception("the error is : $errorMessage");
    } catch (e) {
      final String errorMessage = e.toString();

      throw Exception("the error is :  $errorMessage");
    }
  }

  Future<dynamic> post(
      {required String url, required dynamic body, String? token}) async {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    Response response =
        await dio.post(url, data: body, options: Options(headers: headers));

    return response.data;
  }

  Future<dynamic> put(
      {required String url, required dynamic body, String? token}) async {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    Response response =
        await dio.post(url, data: body, options: Options(headers: headers));

    return response.data;
  }
}
