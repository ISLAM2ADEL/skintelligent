import 'package:flutter/material.dart';
import 'package:skintelligent/models/doctor_model.dart';
import 'package:skintelligent/widgets/stats_row.dart';
import 'package:skintelligent/widgets/about_me_section.dart';
import 'package:skintelligent/widgets/doctor_card.dart';

class DoctorInfoCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorInfoCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DoctorCard(doctor: doctor),
        const SizedBox(height: 24),
        StatsRow(
          experienceYears: doctor.experienceYears,
          qualifications: doctor.clinics[0].contactNumber,
          name: doctor.clinics[0].clinicName,
        ),
        const SizedBox(height: 30),
        AboutMeSection(about: doctor.aboutMe),
      ],
    );
  }
}
