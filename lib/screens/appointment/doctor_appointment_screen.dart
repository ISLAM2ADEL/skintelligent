// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:skintelligent/widgets/doctor_card.dart';
// import 'package:skintelligent/widgets/stats_row.dart';
// import 'package:skintelligent/widgets/about_me_section.dart';
// import 'package:skintelligent/widgets/available_booking.dart';
// import 'package:skintelligent/cubit/available_booking_cubit/available_booking_cubit.dart';
// import 'package:skintelligent/cubit/available_booking_cubit/available_booking_state.dart';
// import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
// import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit_state.dart';

// class DoctorAppointmentScreen extends StatefulWidget {
//   const DoctorAppointmentScreen({super.key});

//   @override
//   State<DoctorAppointmentScreen> createState() =>
//       _DoctorAppointmentScreenState();
// }

// class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
//   DateTime selectedDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     context.read<DoctorCubit>().getDoctorProfile();
//   }

//   List<DateTime> getWeekDates() =>
//       List.generate(7, (index) => selectedDate.add(Duration(days: index)));

//   void updateBooking(DateTime date, {int clinicId = 8, int doctorId = 10}) {
//     context.read<AvailableBookingCubit>().getAvailableBookings(
//           date: DateFormat('yyyy-MM-dd').format(date),
//           clinicId: clinicId,
//           doctorId: doctorId,
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final weekDates = getWeekDates();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Doctor Info', style: TextStyle(color: Colors.black)),
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
//                 crossAxisAlignment: CrossAxisAlignment.start,
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
//                   const Text(
//                     "Today's Schedule",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.arrow_back_ios),
//                         onPressed: () {
//                           setState(() {
//                             selectedDate =
//                                 selectedDate.subtract(const Duration(days: 1));
//                           });
//                           updateBooking(selectedDate);
//                         },
//                       ),
//                       Expanded(
//                         child: SizedBox(
//                           height: 70,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: weekDates.length,
//                             itemBuilder: (context, index) {
//                               final date = weekDates[index];
//                               final isSelected = DateFormat('yyyy-MM-dd')
//                                       .format(date) ==
//                                   DateFormat('yyyy-MM-dd').format(selectedDate);

//                               return GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedDate = date;
//                                   });
//                                   updateBooking(date);
//                                 },
//                                 child: Container(
//                                   margin:
//                                       const EdgeInsets.symmetric(horizontal: 5),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 11, vertical: 10),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? Colors.blue
//                                         : Colors.grey[200],
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         DateFormat('E').format(date),
//                                         style: TextStyle(
//                                           color: isSelected
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Text(
//                                         DateFormat('d').format(date),
//                                         style: TextStyle(
//                                           color: isSelected
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.arrow_forward_ios),
//                         onPressed: () {
//                           setState(() {
//                             selectedDate =
//                                 selectedDate.add(const Duration(days: 1));
//                           });
//                           updateBooking(selectedDate, clinicId: 7, doctorId: 7);
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   BlocBuilder<AvailableBookingCubit, AvailableBookingState>(
//                     builder: (context, bookingState) {
//                       if (bookingState is AvailableBookingLoading) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (bookingState is AvailableBookingFailure) {
//                         return Text("Failed to load: ${bookingState.message}");
//                       } else if (bookingState is AvailableBookingSuccess) {
//                         return AvailableBooking(allSlots: bookingState.data);
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),
//                   const SizedBox(height: 30),
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
import 'package:intl/intl.dart';
import 'package:skintelligent/widgets/review_screen.dart';
import 'package:skintelligent/widgets/doctor_card.dart';
import 'package:skintelligent/widgets/stats_row.dart';
import 'package:skintelligent/widgets/about_me_section.dart';
import 'package:skintelligent/widgets/available_booking.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_cubit.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_state.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit_state.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({
    super.key,
    required this.doctorId,
    required this.clinicId,
  });

  final int doctorId;
  final int clinicId;

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  late DateTime selectedWeekStart;
  late List<DateTime> visibleWeekStartDates;
  late List<DateTime> weekDates;

  int weekOffset = 0;
  int numberOfVisibleWeeks = 4;

  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().getDoctorProfile(widget.doctorId);
    selectedWeekStart = _getStartOfWeek(DateTime.now());
    weekDates = updateBooking(selectedWeekStart);
    visibleWeekStartDates =
        generateWeekStartDates(weekOffset, numberOfVisibleWeeks);
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday % 7));
  }

  List<DateTime> updateBooking(DateTime startOfWeek) {
    context.read<AvailableBookingCubit>().getAvailableBookings(
          date: DateFormat('yyyy-MM-dd').format(startOfWeek),
          clinicId: widget.clinicId,
          doctorId: widget.doctorId,
        );
    return [startOfWeek];
  }

  List<DateTime> generateWeekStartDates(int startOffset, int count) {
    final baseDate =
        _getStartOfWeek(DateTime.now().add(Duration(days: startOffset * 7)));
    return List.generate(count, (i) => baseDate.add(Duration(days: i * 7)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Doctor Info', style: TextStyle(color: Colors.black)),
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
            if (doctor.isApproved) {
              return Center(
                child: Text(
                  "The doctor is still not approved 😔",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorCard(doctor: doctor),
                  const SizedBox(height: 24),
                  StatsRow(
                    experienceYears: doctor.experienceYears,
                    phoneNumber: doctor.phoneNumber,
                    email: doctor.email,
                  ),
                  const SizedBox(height: 30),
                  AboutMeSection(about: doctor.aboutMe),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewViewScreen(
                            doctorID: 9,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Show Reviews ",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Weekly's Schedule",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(() {
                            weekOffset -= numberOfVisibleWeeks;
                            visibleWeekStartDates = generateWeekStartDates(
                                weekOffset, numberOfVisibleWeeks);
                          });
                        },
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: visibleWeekStartDates.length,
                            itemBuilder: (context, index) {
                              final date = visibleWeekStartDates[index];
                              final isSelected =
                                  DateFormat('yyyy-MM-dd').format(date) ==
                                      DateFormat('yyyy-MM-dd')
                                          .format(selectedWeekStart);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedWeekStart = date;
                                    weekDates = updateBooking(date);
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('E').format(date),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        DateFormat('d').format(date),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          setState(() {
                            weekOffset += numberOfVisibleWeeks;
                            visibleWeekStartDates = generateWeekStartDates(
                                weekOffset, numberOfVisibleWeeks);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<AvailableBookingCubit, AvailableBookingState>(
                    builder: (context, bookingState) {
                      if (bookingState is AvailableBookingLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (bookingState is AvailableBookingFailure) {
                        return Text("Failed to load: ${bookingState.message}");
                      } else if (bookingState is AvailableBookingSuccess) {
                        return AvailableBooking(allSlots: bookingState.data);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 30),
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
