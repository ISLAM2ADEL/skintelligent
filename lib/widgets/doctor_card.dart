// lib/features/doctor/presentation/widgets/doctor_card.dart
import 'package:flutter/material.dart';
import 'package:skintelligent/models/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.withValues(alpha: 0.1),
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              doctor.profilePicture,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. ${doctor.firstName} ${doctor.lastName}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(doctor.qualification,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
