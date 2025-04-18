// lib/features/doctor/presentation/widgets/booking_slot.dart
import 'package:flutter/material.dart';

class BookingSlot extends StatelessWidget {
  final String time;

  const BookingSlot({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected: $time")),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          time,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
