// // lib/features/doctor/presentation/widgets/booking_slot.dart
import 'package:flutter/material.dart';

// class BookingSlot extends StatelessWidget {
//   final String time;

//   const BookingSlot({super.key, required this.time});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Selected: $time")),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.05),
//               blurRadius: 5,
//               offset: const Offset(0, 2),
//             )
//           ],
//         ),
//         child: Text(
//           time,
//           style: const TextStyle(fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }
// }

// class BookingSlot extends StatelessWidget {
//   final String time;

//   const BookingSlot({
//     super.key,
//     required this.time,

//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           color:  Colors.grey[200],
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.black12),
//         ),
//         child: Text(
//           time,
//           style: const TextStyle(
//             color:  Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:skintelligent/models/available_booking_model.dart';
import 'package:skintelligent/utiles/booking_store.dart';

class BookingSlot extends StatelessWidget {
  final String time;
  final DateTime slotDateTime; // لتحديد وقت الحجز بدقة

  const BookingSlot({
    super.key,
    required this.time,
    required this.slotDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isAlreadyBooked = BookingStore().selectedSlots.any(
              (slot) => slot.startTime == slotDateTime,
            );

        final message =
            isAlreadyBooked ? "Booked before" : "Booking successfully";

        if (!isAlreadyBooked) {
          BookingStore().selectedSlots.add(
                AppointmentSlot(
                  id: 0,
                  startTime: slotDateTime,
                  endTime: slotDateTime.add(const Duration(minutes: 20)),
                  isCanceled: false,
                  isBooked: false,
                  repeatUntil: slotDateTime,
                ),
              );
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: isAlreadyBooked ? Colors.orange : Colors.green,
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          time,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
