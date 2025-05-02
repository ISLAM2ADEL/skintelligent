import 'package:flutter/material.dart';
import 'package:skintelligent/models/available_booking_model.dart';
import 'booking_slot.dart';

// class AvailableBooking extends StatelessWidget {
//   final Map<String, List<AppointmentSlot>> allSlots;

//   const AvailableBooking({super.key, required this.allSlots});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: allSlots.entries.map((entry) {
//         final String day = entry.key;
//         final List<AppointmentSlot> slots = entry.value;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               day,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             if (slots.isEmpty)
//               const Text("No slots available.",
//                   style: TextStyle(color: Colors.grey))
//             else
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: slots.map((slot) {
//                   final time = TimeOfDay.fromDateTime(slot.startTime);
//                   return BookingSlot(time: time.format(context));
//                 }).toList(),
//               ),
//             const SizedBox(height: 20),
//           ],
//         );
//       }).toList(),
//     );
//   }
// }

// تأكد أنك تستخدم نسخة BookingSlot المعدلة

// class AvailableBooking extends StatelessWidget {
//   final Map<String, List<AppointmentSlot>> allSlots;
  
//   const AvailableBooking({super.key, required this.allSlots});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: allSlots.entries.map((entry) {
//         final String day = entry.key;
//         final List<AppointmentSlot> slots = {
//           for (var slot in entry.value) slot.startTime.toIso8601String(): slot
//         }.values.toList();
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "${day}${slots.isNotEmpty ? " - ${slots.first.startTime.toLocal().toString().split(' ')[0]}" : ""}",
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             if (slots.isEmpty)
//               const Text("No slots available.",
//                   style: TextStyle(color: Colors.grey))
//             else
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: slots.map((slot) {
//                   final time =
//                       TimeOfDay.fromDateTime(slot.startTime).format(context);

//                   return BookingSlot(
//                     time: time,
//                     slotDateTime: slot.startTime,
//                   );
//                 }).toList(),
//               ),
//             const SizedBox(height: 20),
//           ],
//         );
//       }).toList(),
//     );
//   }
// }


class AvailableBooking extends StatelessWidget {
  final Map<String, List<Session>> allSlots;

  const AvailableBooking({super.key, required this.allSlots});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: allSlots.entries.map((entry) {
        final String day = entry.key;
        final List<Session> slots = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$day${slots.isNotEmpty ? " - ${DateTime.parse(slots.first.startTime).toLocal().toString().split(' ')[0]}" : ""}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  final startDateTime = DateTime.parse(slot.startTime);
                  final time = TimeOfDay.fromDateTime(startDateTime).format(context);

                  return BookingSlot(
                    time: time,
                    session: slot,
                  );
                }).toList(),
              ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }
}
