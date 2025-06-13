import 'package:flutter/material.dart';
import 'package:skintelligent/screens/ChatbotScrean/chatbotScreen.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import '../../controllers/cache/cache_helper.dart';
import '../../controllers/api/endpoint.dart';
import '../../services/service_locator.dart';

class UploadingScreen extends StatefulWidget {
  final File imageFile;
  final int appointmentId;

  const UploadingScreen({
    super.key,
    required this.imageFile,
    required this.appointmentId,
  });

  @override
  State<UploadingScreen> createState() => _UploadingScreenState();
}

class _UploadingScreenState extends State<UploadingScreen> {
  @override
  void initState() {
    super.initState();
    _uploadImageAndNavigate();
  }

  Future<void> _uploadImageAndNavigate() async {
    String token = getIt<CacheHelper>().getData(key: ApiKey.Authorization);
    final formData = FormData.fromMap({
      'AppointmentId': widget.appointmentId,
      'ImageFile': await MultipartFile.fromFile(
        widget.imageFile.path,
        filename: widget.imageFile.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    try {
      final response = await Dio().post(
        'http://skintelligent.runasp.net/api/chats/upload-image',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      print('✅ Image uploaded: ${response.statusCode}');
    } catch (e) {
      print('❌ Upload failed: $e');
    }

    Navigator.pushReplacementNamed(
      context,
      Chatbotscreen.id,
      arguments: {
        "appointmentID": widget.appointmentId,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("جارٍ رفع الصورة... من فضلك انتظر",
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
