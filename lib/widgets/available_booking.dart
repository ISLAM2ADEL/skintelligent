// // lib/features/doctor/presentation/widgets/available_booking.dart
// import 'package:flutter/material.dart';
// import 'booking_slot.dart';

// class AvailableBooking extends StatelessWidget {
//   const AvailableBooking({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Available Booking", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: const [
//             BookingSlot(time: "10:00 AM"),
//             BookingSlot(time: "11:30 AM"),
//             BookingSlot(time: "1:00 PM"),
//             BookingSlot(time: "2:30 PM"),
//             BookingSlot(time: "4:00 PM"),
//             BookingSlot(time: "5:30 PM"),
//           ],
//         ),
//       ],
//     );
//   }
// }

// lib/widgets/available_booking.dart

import 'package:flutter/material.dart';
import 'package:skintelligent/models/available_booking_model.dart';
import 'booking_slot.dart';

class AvailableBooking extends StatelessWidget {
  final Map<String, List<AppointmentSlot>> allSlots;

  const AvailableBooking({super.key, required this.allSlots});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: allSlots.entries.map((entry) {
        final String day = entry.key;
        final List<AppointmentSlot> slots = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (slots.isEmpty)
              const Text("No slots available.",
                  style: TextStyle(color: Colors.grey))
            else
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: slots.map((slot) {
                  final time = TimeOfDay.fromDateTime(slot.startTime);
                  return BookingSlot(time: time.format(context));
                }).toList(),
              ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }
}
