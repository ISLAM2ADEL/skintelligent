// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
// import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit_state.dart';
// import 'package:skintelligent/widgets/doctor_card.dart';
// import 'package:skintelligent/widgets/stats_row.dart';
// import 'package:skintelligent/widgets/about_me_section.dart';
// import 'package:skintelligent/widgets/available_booking.dart';
// // import 'package:skintelligent/widgets/voice_call_button.dart';

// class AppointmentScreen extends StatefulWidget {
//   const AppointmentScreen({super.key});

//   @override
//   State<AppointmentScreen> createState() => _AppointmentScreenState();
// }

// class _AppointmentScreenState extends State<AppointmentScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<DoctorCubit>().getDoctorProfile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Doctor Info',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: BlocBuilder<DoctorCubit, DoctorState>(
//         builder: (context, state) {
//           if (state is GetDoctorLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (state is GetDoctorFailure) {
//             return Center(
//               child: Text(
//                 'Error: ${state.errMessage}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           }

//           if (state is GetDoctorSuccess) {
//             final doctor = state.doctor;

//             if (!doctor.isApproved) {
//               return Center(
//                 child: Text(
//                   "The doctor is still not approved 😔",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withValues(alpha: 0.7),
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               );
//             }

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   DoctorCard(doctor: doctor),
//                   const SizedBox(height: 24),
//                   StatsRow(
//                     experienceYears: doctor.experienceYears,
//                     gender: doctor.gender,
//                     email: doctor.email,
//                   ),
//                   const SizedBox(height: 30),
//                   AboutMeSection(about: doctor.aboutMe),
//                   const SizedBox(height: 30),
//                   const AvailableBooking(),
//                   const SizedBox(height: 30),
//                   // const VoiceCallButton(),
//                 ],
//               ),
//             );
//           }

//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:skintelligent/cubit/available_booking_cubit/available_booking_cubit.dart';
// import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
// import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit_state.dart';
// import 'package:skintelligent/cubit/available_booking_cubit/available_booking_state.dart';
// import 'package:skintelligent/widgets/doctor_card.dart';
// import 'package:skintelligent/widgets/stats_row.dart';
// import 'package:skintelligent/widgets/about_me_section.dart';
// import 'package:skintelligent/widgets/available_booking.dart';

// class DoctorAppointmentScreen extends StatefulWidget {
//   const DoctorAppointmentScreen({super.key});

//   @override
//   State<DoctorAppointmentScreen> createState() =>
//       _DoctorAppointmentScreenState();
// }

// class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<DoctorCubit>().getDoctorProfile();

//     // Fetch available bookings for the week
//     context.read<AvailableBookingCubit>().getAvailableBookings(
//           // date: DateTime.now().toIso8601String().split('T').first,
//           date: "2025-04-20",
//           clinicId: 7,
//           doctorId: 7,
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Doctor Info',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: BlocBuilder<DoctorCubit, DoctorState>(
//         builder: (context, state) {
//           if (state is GetDoctorLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is GetDoctorFailure) {
//             return Center(
//               child: Text(
//                 'Error: ${state.errMessage}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           }

//           if (state is GetDoctorSuccess) {
//             final doctor = state.doctor;

//             if (!doctor.isApproved) {
//               return Center(
//                 child: Text(
//                   "The doctor is still not approved 😔",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black.withValues(alpha: 0.7),
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               );
//             }

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   DoctorCard(doctor: doctor),
//                   const SizedBox(height: 24),
//                   StatsRow(
//                     experienceYears: doctor.experienceYears,
//                     gender: doctor.gender,
//                     email: doctor.email,
//                   ),
//                   const SizedBox(height: 30),
//                   AboutMeSection(about: doctor.aboutMe),
//                   const SizedBox(height: 30),
//                   BlocBuilder<AvailableBookingCubit, AvailableBookingState>(
//                     builder: (context, bookingState) {
//                       if (bookingState is AvailableBookingLoading) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (bookingState is AvailableBookingFailure) {
//                         return Text("Failed to load: ${bookingState.message}");
//                       } else if (bookingState is AvailableBookingSuccess) {
//                         // ✅ Show all available days instead of just one
//                         return AvailableBooking(
//                           allSlots: bookingState.data,
//                         );
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),
//                   const SizedBox(height: 30),
//                   // const VoiceCallButton(),
//                 ],
//               ),
//             );
//           }

//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_cubit.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_state.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit_state.dart';
import 'package:skintelligent/widgets/doctor_card.dart';
import 'package:skintelligent/widgets/stats_row.dart';
import 'package:skintelligent/widgets/about_me_section.dart';
import 'package:skintelligent/widgets/available_booking.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  DateTime? selectedDate;

  @override
  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().getDoctorProfile();

    final bookingCubit = context.read<AvailableBookingCubit>();
    final currentState = bookingCubit.state;

    if (currentState is! AvailableBookingSuccess) {
      final nowDate = DateTime.now().toIso8601String().split('T').first;

      bookingCubit.getAvailableBookings(
        date: nowDate,
        clinicId: 7,
        doctorId: 7,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Doctor Info',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is GetDoctorLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetDoctorFailure) {
            return Center(
              child: Text(
                'Error: ${state.errMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is GetDoctorSuccess) {
            final doctor = state.doctor;

            if (!doctor.isApproved) {
              return Center(
                child: Text(
                  "The doctor is still not approved 😔",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  DoctorCard(doctor: doctor),
                  const SizedBox(height: 24),
                  StatsRow(
                    experienceYears: doctor.experienceYears,
                    gender: doctor.gender,
                    email: doctor.email,
                  ),
                  const SizedBox(height: 30),
                  AboutMeSection(about: doctor.aboutMe),
                  const SizedBox(height: 30),

                  // ✅ زر اختيار التاريخ
                  ElevatedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 1)),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );

                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });

                        context
                            .read<AvailableBookingCubit>()
                            .getAvailableBookings(
                              date: picked.toIso8601String().split('T').first,
                              clinicId: 7,
                              doctorId: 7,
                            );
                      }
                    },
                    child: const Text("Choose the date"),
                  ),
                  const SizedBox(height: 20),

                  BlocBuilder<AvailableBookingCubit, AvailableBookingState>(
                    builder: (context, bookingState) {
                      if (bookingState is AvailableBookingLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (bookingState is AvailableBookingFailure) {
                        return Text("Failed to load: ${bookingState.message}");
                      } else if (bookingState is AvailableBookingSuccess) {
                        return AvailableBooking(
                          allSlots: bookingState.data,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  const SizedBox(height: 30),
                  // const VoiceCallButton(),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
