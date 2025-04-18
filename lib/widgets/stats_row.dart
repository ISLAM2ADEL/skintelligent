// lib/features/doctor/presentation/widgets/stats_row.dart

import 'package:flutter/material.dart';
import 'package:skintelligent/widgets/info_row.dart';

class StatsRow extends StatelessWidget {
  final int experienceYears;
  final String gender;
  final String email;

  const StatsRow({
    super.key,
    required this.experienceYears,
    required this.gender,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(title: "Experience", value: "$experienceYears years"),
        const SizedBox(height: 10),
        InfoRow(title: "Gender", value: gender),
        const SizedBox(height: 10),
        InfoRow(title: "Email", value: email),
      ],
    );
  }
}
