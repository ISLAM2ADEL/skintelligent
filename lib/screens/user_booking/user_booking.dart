// import 'package:skintelligent/commons.dart';
// import 'package:skintelligent/models/available_booking_model.dart';
// import 'package:skintelligent/utiles/booking_store.dart';
// import 'package:intl/intl.dart';

// class UserBookingScreen extends StatefulWidget {
//   const UserBookingScreen({super.key});
//   static const String id = 'UserBookingScreen';

//   @override
//   State<UserBookingScreen> createState() => _UserBookingScreenState();
// }

// class _UserBookingScreenState extends State<UserBookingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final List<AppointmentSlot> bookedSlots =
//         BookingStore().selectedSlots.toList();

//     return Scaffold(
//       appBar: AppBar(title: const Text('My Bookings')),
//       body: bookedSlots.isEmpty
//           ? const Center(child: Text("No bookings yet."))
//           : ListView.builder(
//               itemCount: bookedSlots.length,
//               itemBuilder: (context, index) {
//                 final slot = bookedSlots[index];
//                 final dayName = DateFormat.EEEE().format(slot.startTime);
//                 final date = slot.startTime.toLocal().toString().split(' ')[0];
//                 final time =
//                     TimeOfDay.fromDateTime(slot.startTime).format(context);

//                 return ListTile(
//                   title: Text("Timing: $time"),
//                   subtitle: Text("Day: $dayName  |  Date: $date"),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: () {
//                       setState(() {
//                         BookingStore().selectedSlots.remove(slot);
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/models/available_booking_model.dart';
import 'package:skintelligent/utiles/booking_store.dart';
import 'package:intl/intl.dart';

class UserBookingScreen extends StatefulWidget {
  const UserBookingScreen({super.key});
  static const String id = 'UserBookingScreen';

  @override
  State<UserBookingScreen> createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends State<UserBookingScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Session> bookedSlots = BookingStore().selectedSlots.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: bookedSlots.isEmpty
          ? const Center(child: Text("No bookings yet."))
          : ListView.builder(
              itemCount: bookedSlots.length,
              itemBuilder: (context, index) {
                final slot = bookedSlots[index];

                // نحول ال startTime من String لـ DateTime
                final startDateTime = DateTime.parse(slot.startTime);

                final dayName = DateFormat.EEEE().format(startDateTime); // Sunday, Monday...
                final date = DateFormat('yyyy-MM-dd').format(startDateTime); // 2025-04-23
                final time = TimeOfDay.fromDateTime(startDateTime).format(context); // 6:00 PM

                return ListTile(
                  title: Text("Timing: $time"),
                  subtitle: Text("Day: $dayName  |  Date: $date"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        BookingStore().selectedSlots.remove(slot);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
