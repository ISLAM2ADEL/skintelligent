// lib/features/doctor/presentation/widgets/stats_row.dart

import 'package:flutter/material.dart';
import 'package:skintelligent/widgets/info_row.dart';

class StatsRow extends StatelessWidget {
  final int experienceYears;
  final String phoneNumber;
  final String email;

  const StatsRow({
    super.key,
    required this.experienceYears,
    required this.phoneNumber,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(title: "Experience", value: "$experienceYears years"),
        const SizedBox(height: 10),
        InfoRow(title: "phone number", value: phoneNumber),
        const SizedBox(height: 10),
        InfoRow(title: "Email", value: email),
      ],
    );
  }
}
