import 'package:flutter/material.dart';
import 'package:skintelligent/models/available_booking_model.dart';
import 'package:skintelligent/utiles/booking_store.dart';
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

class AvailableBooking extends StatefulWidget {
  final Map<String, List<AppointmentSlot>> allSlots;

  const AvailableBooking({super.key, required this.allSlots});

  @override
  State<AvailableBooking> createState() => _AvailableBookingState();
}

class _AvailableBookingState extends State<AvailableBooking> {
  final Set<AppointmentSlot> selectedSlots = BookingStore().selectedSlots;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.allSlots.entries.map((entry) {
        final String day = entry.key;
        final List<AppointmentSlot> slots = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${day}${slots.isNotEmpty ? " - ${slots.first.startTime.toLocal().toString().split(' ')[0]}" : ""}",
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
                  final time =
                      TimeOfDay.fromDateTime(slot.startTime).format(context);
                  final isSelected = selectedSlots.contains(slot);

                  return BookingSlot(
                    time: time,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedSlots.remove(slot);
                        } else {
                          selectedSlots.add(slot);
                        }
                      });
                    },
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
