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
    final List<AppointmentSlot> bookedSlots =
        BookingStore().selectedSlots.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: bookedSlots.isEmpty
          ? const Center(child: Text("No bookings yet."))
          : ListView.builder(
              itemCount: bookedSlots.length,
              itemBuilder: (context, index) {
                final slot = bookedSlots[index];
                final dayName = DateFormat.EEEE().format(slot.startTime);
                final date = slot.startTime.toLocal().toString().split(' ')[0];
                final time =
                    TimeOfDay.fromDateTime(slot.startTime).format(context);

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
