// lib/features/doctor/presentation/widgets/about_me_section.dart
import 'package:flutter/material.dart';

class AboutMeSection extends StatelessWidget {
  final String about;

  const AboutMeSection({super.key, required this.about});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("About Me",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(about,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.justify),
        const SizedBox(height: 20),
      ],
    );
  }
}
