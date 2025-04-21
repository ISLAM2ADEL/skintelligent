// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

// class TestOtpVerificationScreen extends StatefulWidget {
//   final String email;

//   const TestOtpVerificationScreen({super.key, required this.email});

//   @override
//   State<TestOtpVerificationScreen> createState() => _TestOtpVerificationScreenState();
// }

// class _TestOtpVerificationScreenState extends State<TestOtpVerificationScreen> {
//   final Dio _dio = Dio();
//   bool _loading = false;
//   String? _otpCode;

//   Future<void> _verifyOtp() async {
//     if (_otpCode == null || _otpCode!.length != 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
//       );
//       return;
//     }

//     setState(() {
//       _loading = true;
//     });

//     try {
//       final response = await _dio.post(
//         "http://skintelligent.runasp.net/api/auth/confirm-email",
//         data: {
//           "email": widget.email,
//           "otpCode": _otpCode,
//         },
//       );

//       if (response.statusCode == 200 && response.data['statusCode'] == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(response.data['message'])),
//         );
//         // TODO: Navigate to login or dashboard
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(response.data['message'] ?? 'OTP verification failed')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Something went wrong: ${e.toString()}')),
//       );
//     } finally {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Verify OTP')),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             Text(
//               "Enter the OTP sent to ${widget.email}",
//               style: const TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             OtpTextField(
//               numberOfFields: 6,
//               borderColor: const Color(0xFF512DA8),
//               focusedBorderColor: Colors.deepPurple,
//               showFieldAsBox: true,
//               onCodeChanged: (String code) {},
//               onSubmit: (String verificationCode) {
//                 _otpCode = verificationCode;
//               },
//             ),
//             const SizedBox(height: 32),
//             _loading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: _verifyOtp,
//                     child: const Text("Verify OTP"),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../screens/login_and_register/login.dart';

class TestOtpVerificationScreen extends StatefulWidget {
  final String email;

  const TestOtpVerificationScreen({super.key, required this.email});

  @override
  State<TestOtpVerificationScreen> createState() => _TestOtpVerificationScreenState();
}

class _TestOtpVerificationScreenState extends State<TestOtpVerificationScreen> {
  final Dio _dio = Dio();
  bool _loading = false;
  String? _otpCode;

  Future<void> _verifyOtp() async {
    if (_otpCode == null || _otpCode!.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final response = await _dio.post(
        "http://skintelligent.runasp.net/api/auth/confirm-email",
        data: {
          "email": widget.email,
          "otpCode": _otpCode,
        },
      );

      if (response.statusCode == 200 && response.data['statusCode'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'])),
        );

        // ✅ Navigate to login screen
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? 'OTP verification failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong: ${e.toString()}')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              "Enter the OTP sent to ${widget.email}",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            OtpTextField(
              numberOfFields: 6,
              borderColor: const Color(0xFF512DA8),
              focusedBorderColor: Colors.deepPurple,
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                _otpCode = verificationCode;
              },
            ),
            const SizedBox(height: 32),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _verifyOtp,
                    child: const Text("Verify OTP"),
                  ),
          ],
        ),
      ),
    );
  }
}
