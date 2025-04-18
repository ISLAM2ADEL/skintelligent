// lib/features/doctor/presentation/widgets/available_booking.dart
import 'package:flutter/material.dart';
import 'booking_slot.dart';

class AvailableBooking extends StatelessWidget {
  const AvailableBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Available Booking", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            BookingSlot(time: "10:00 AM"),
            BookingSlot(time: "11:30 AM"),
            BookingSlot(time: "1:00 PM"),
            BookingSlot(time: "2:30 PM"),
            BookingSlot(time: "4:00 PM"),
            BookingSlot(time: "5:30 PM"),
          ],
        ),
      ],
    );
  }
}
