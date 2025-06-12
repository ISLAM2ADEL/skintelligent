import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // مهمة جداً لـ context.read
import 'package:skintelligent/models/available_booking_model.dart';
import 'package:skintelligent/cubit/make_booking_cubit/make_booking_cubit.dart';

class BookingSlot extends StatefulWidget {
  final String time;
  final Session session;
  final bool booked;

  const BookingSlot({
    super.key,
    required this.time,
    required this.session,
    this.booked = false,
  });

  @override
  State<BookingSlot> createState() => _BookingSlotState();
}

class _BookingSlotState extends State<BookingSlot> {
  bool isBooked = false;

  @override
  void initState() {
    super.initState();
    isBooked = widget.booked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Change the color immediately
        setState(() {
          isBooked = true;
        });

        // Trigger the booking action via the Cubit
        context
            .read<MakeBookingCubit>()
            .makeBooking(appointmentId: widget.session.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          widget.time,
          style: TextStyle(
            color: isBooked ? Colors.grey : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
