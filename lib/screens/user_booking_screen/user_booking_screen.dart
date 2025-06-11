import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:skintelligent/cubit/user_appointment_cancel_cubit/user_appointment_cancel_cubit.dart';
import 'package:skintelligent/cubit/user_appointment_cancel_cubit/user_appointment_cancel_state.dart';
import 'package:skintelligent/cubit/user_booking_cubit/user_booking_cubit.dart';
import 'package:skintelligent/cubit/user_booking_cubit/user_booking_state.dart';

class UserBookingScreen extends StatefulWidget {
  const UserBookingScreen({super.key});
  static const String id = 'UserBookingScreen';

  @override
  State<UserBookingScreen> createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends State<UserBookingScreen> {
  @override
  initState() {
    super.initState();
    // Fetch the bookings when the screen is initialized
    context.read<UserBookingCubit>().fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserAppointmentCancelCubit, UserAppointmentCancelState>(
      listener: (context, cancelState) {
        if (cancelState is UserAppointmentCancelSuccess) {
          context.read<UserBookingCubit>().fetchBookings();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Booking canceled successfully.")),
          );
        } else if (cancelState is UserAppointmentCancelFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ ${cancelState.message}")),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
        ),
        body: _buildBookingList(context),
      ),
    );
  }

  Widget _buildBookingList(BuildContext context) {
    return BlocBuilder<UserBookingCubit, UserBookingState>(
      builder: (context, state) {
        if (state is UserBookingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserBookingFailure) {
          return const Center(child: Text("❌ No booked appointments found",style: TextStyle(
            fontSize: 18,
            color: Colors.grey
          ),));
        } else if (state is UserBookingSuccess) {
          if (state.bookings.isEmpty) {
            return const Center(child: Text("No bookings yet."));
          }

          final sortedBookings = [...state.bookings]
            ..sort((a, b) => b.startTime.compareTo(a.startTime));

          return ListView.builder(
            itemCount: sortedBookings.length,
            itemBuilder: (context, index) {
              final booking = sortedBookings[index];
              final startDateTime = booking.startTime;
              // final endDateTime = booking.endTime;
              final dayName = DateFormat.EEEE().format(startDateTime);
              final date = DateFormat('yyyy-MM-dd').format(startDateTime);
              final startTime =
                  TimeOfDay.fromDateTime(startDateTime).format(context);
              final endTime =
                  TimeOfDay.fromDateTime(startDateTime).format(context);

              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        context
                            .read<UserAppointmentCancelCubit>()
                            .fetchCancelAppointments(appointmentId: booking.id);
                      },
                      icon: Icons.cancel,
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          title:
                              Text("${index + 1}.Doctor: ${booking.doctorName}"),
                          subtitle: Text(
                            "Date: $dayName - $date \nTime: $startTime -> $endTime\nClinic Name: ${booking.clinicName}",
                          ),
                          trailing: booking.isCanceled
                              ? const Icon(Icons.cancel, color: Colors.red)
                              : const Icon(Icons.check_circle,
                                  color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              );
            },
          );
        }

        return const Center(child: Text("Unknown state."));
      },
    );
  }
}
