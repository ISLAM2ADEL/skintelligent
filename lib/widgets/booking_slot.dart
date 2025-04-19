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

class BookingSlot extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const BookingSlot({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          time,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
