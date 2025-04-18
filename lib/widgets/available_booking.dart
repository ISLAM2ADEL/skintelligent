

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
