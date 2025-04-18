// import 'package:flutter/material.dart';

// class MedicalAppointmentScreen extends StatelessWidget {
//   const MedicalAppointmentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor:
//             const Color(0xFF5555eb), // Background matching the top gradient
//         elevation: 0,
//       ),
//       backgroundColor:
//           const Color(0xFF5555eb), // Background matching the top gradient
//       body: Stack(
//         children: [
//           // Doctor Image
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Image.asset(
//                 'assets/images/removed doctor.png', // replace with your asset path
//                 height: size.height * 0.5,
//               ),
//             ),
//           ),

//           // Bottom Container
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: size.height * 0.45,
//               padding: const EdgeInsets.all(24),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 16),
//                   const Text(
//                     'More Comfortable Chat\nWith the Doctor',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     'Book an appointment with doctor. Chat with doctor via appointment letter and get consultation.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Page Indicator

//                   const SizedBox(height: 25),

//                   // Get Started Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigate to next screen
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF5A46FF),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Get Started',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class AppointmentScreen extends StatelessWidget {
//   const AppointmentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title:
//             const Text('My Appointment', style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // Doctor Card
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 10,
//                     color: Colors.grey.withOpacity(0.1),
//                     offset: const Offset(0, 5),
//                   )
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(20)),
//                     child: Image.asset(
//                       'assets/images/removed doctor.png', // Replace with your image
//                       fit: BoxFit.contain,
//                       width: double.infinity,
//                       height: 200,
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Dr. Jenny Wilson",
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 4),
//                         Text("Neurologist | Vcare Clinic",
//                             style: TextStyle(color: Colors.grey)),
//                         SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Icon(Icons.star, color: Colors.amber, size: 20),
//                             SizedBox(width: 4),
//                             Text("5.0",
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             SizedBox(width: 4),
//                             Text("(332 reviews)",
//                                 style: TextStyle(color: Colors.grey)),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Stats Row
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _StatItem(
//                     icon: Icons.people, label: "120+", sublabel: "Patients"),
//                 _StatItem(
//                     icon: Icons.calendar_today,
//                     label: "7+",
//                     sublabel: "Years Exp"),
//                 _StatItem(
//                     icon: Icons.star_border, label: "4.9", sublabel: "Rating"),
//                 _StatItem(
//                     icon: Icons.reviews, label: "100+", sublabel: "Reviews"),
//               ],
//             ),
//             const SizedBox(height: 30),

//             // About Me
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "About Me",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Dr. Carly Angel is the top most immunologists specialist in Crist Hospital in London, UK.",
//               style: TextStyle(color: Colors.grey),
//               textAlign: TextAlign.justify,
//             ),
//             const SizedBox(height: 30),

//             // Available Booking
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Available Booking",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: const [
//                 BookingSlot(time: "10:00 AM"),
//                 BookingSlot(time: "11:30 AM"),
//                 BookingSlot(time: "1:00 PM"),
//                 BookingSlot(time: "2:30 PM"),
//                 BookingSlot(time: "4:00 PM"),
//                 BookingSlot(time: "5:30 PM"),
//               ],
//             ),
//             const SizedBox(height: 30),

//             // Voice Call Button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   // Add call action here
//                 },
//                 icon: const Icon(Icons.call, color: Colors.white),
//                 label: const Text("Voice Call (14.30 - 15.00 PM)",
//                     style: TextStyle(fontSize: 16, color: Colors.white)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF5A46FF),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _StatItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String sublabel;

//   const _StatItem(
//       {required this.icon, required this.label, required this.sublabel});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, color: Color(0xFF5A46FF)),
//         const SizedBox(height: 8),
//         Text(label,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         Text(sublabel, style: const TextStyle(color: Colors.grey)),
//       ],
//     );
//   }
// }

// class BookingSlot extends StatelessWidget {
//   final String time;

//   const BookingSlot({super.key, required this.time});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         // Handle booking tap
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
// import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit_state.dart';
// import 'package:skintelligent/models/doctor_model.dart';

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
//         title: const Text('Doctor Info', style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: BlocBuilder<DoctorCubit, DoctorState>(
//         builder: (context, state) {
//           if (state is GetDoctorLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is GetDoctorFailure) {
//             return Center(child: Text('Error: ${state.errMessage}'));
//           } else if (state is GetDoctorSuccess) {
//             final doctor = state.doctor;

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   _DoctorCard(doctor: doctor),
//                   const SizedBox(height: 24),
//                   _StatsRow(experienceYears: doctor.experienceYears),
//                   const SizedBox(height: 30),
//                   _AboutMeSection(about: doctor.aboutMe),
//                   const SizedBox(height: 30),
//                   _AvailableBooking(),
//                   const SizedBox(height: 30),
//                   _VoiceCallButton(),
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

// class _DoctorCard extends StatelessWidget {
//   final DoctorModel doctor;

//   const _DoctorCard({required this.doctor});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 10,
//             color: Colors.grey.withOpacity(0.1),
//             offset: const Offset(0, 5),
//           )
//         ],
//       ),
//       child: Column(
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//             child: Image.network(
//               doctor.profilePicture,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: 200,
//               errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Dr. ${doctor.firstName} ${doctor.lastName}",
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(doctor.qualification,
//                     style: const TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StatsRow extends StatelessWidget {
//   final int experienceYears;

//   const _StatsRow({required this.experienceYears});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _StatItem(
//           icon: Icons.calendar_today,
//           label: "$experienceYears+",
//           sublabel: "Years Exp",
//         ),
//       ],
//     );
//   }
// }

// class _StatItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String sublabel;

//   const _StatItem({
//     required this.icon,
//     required this.label,
//     required this.sublabel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, color: const Color(0xFF5A46FF)),
//         const SizedBox(height: 8),
//         Text(label,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         Text(sublabel, style: const TextStyle(color: Colors.grey)),
//       ],
//     );
//   }
// }

// class _AboutMeSection extends StatelessWidget {
//   final String about;

//   const _AboutMeSection({required this.about});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("About Me",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 10),
//         Text(about,
//             style: const TextStyle(color: Colors.grey),
//             textAlign: TextAlign.justify),
//       ],
//     );
//   }
// }

// class _AvailableBooking extends StatelessWidget {
//   const _AvailableBooking();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Available Booking",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: const [
//             BookingSlot(time: "10:00 AM"),
//             BookingSlot(time: "11:30 AM"),
//             BookingSlot(time: "1:00 PM"),
//             BookingSlot(time: "2:30 PM"),
//             BookingSlot(time: "4:00 PM"),
//             BookingSlot(time: "5:30 PM"),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _VoiceCallButton extends StatelessWidget {
//   const _VoiceCallButton();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton.icon(
//         onPressed: () {
//           // Add call action
//         },
//         icon: const Icon(Icons.call, color: Colors.white),
//         label: const Text("Voice Call (14.30 - 15.00 PM)",
//             style: TextStyle(fontSize: 16, color: Colors.white)),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF5A46FF),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }
// }

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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit_state.dart';
import 'package:skintelligent/widgets/doctor_card.dart';
import 'package:skintelligent/widgets/stats_row.dart';
import 'package:skintelligent/widgets/about_me_section.dart';
import 'package:skintelligent/widgets/available_booking.dart';
// import 'package:skintelligent/widgets/voice_call_button.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().getDoctorProfile();
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
            return const Center(
              child: CircularProgressIndicator(),
            );
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
                    color: Colors.black.withValues(alpha: 0.7),
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
                  const AvailableBooking(),
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
