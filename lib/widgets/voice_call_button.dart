// lib/features/doctor/presentation/widgets/voice_call_button.dart
import 'package:flutter/material.dart';

class VoiceCallButton extends StatelessWidget {
  const VoiceCallButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          // Add call action
        },
        icon: const Icon(Icons.call, color: Colors.white),
        label: const Text("Voice Call (14.30 - 15.00 PM)",
            style: TextStyle(fontSize: 16, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5A46FF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
