// lib/features/doctor/presentation/widgets/stats_row.dart

import 'package:flutter/material.dart';
import 'package:skintelligent/widgets/info_row.dart';

class StatsRow extends StatelessWidget {
  final int experienceYears;
  final String qualifications;
  final String name;

  const StatsRow({
    super.key,
    required this.experienceYears,
    required this.qualifications,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(title: "Experience", value: "$experienceYears years"),
        const SizedBox(height: 10),
        InfoRow(title: "Clinic Contact Number", value: qualifications),
        const SizedBox(height: 10),
        InfoRow(title: "Clinic Name", value: name),
      ],
    );
  }
}
