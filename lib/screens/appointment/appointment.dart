import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/const/const.dart';
import 'package:skintelligent/const/custom_bottom_bar.dart';
import 'package:skintelligent/screens/appointment/doctor_appointment_screen.dart';

import '../../commons.dart';
class Appointment extends StatelessWidget {
  const Appointment({super.key});
  static const String id = 'Appointment';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cubit= context.read<AppointmentCubit>();
    cubit.getAllDoctors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Doctor Appointments'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: height*.05,),
          BlocBuilder<AppointmentCubit, AppointmentState>(
            builder: (context, state) {
              if (state is AppointmentLoading || state is AppointmentSortLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AppointmentFailure) {
                return Center(child: Text(state.errorMessage));
              }else if (state is AppointmentSortFailure) {
                return Center(child: Text(state.errorMessage));
              }
              else if (state is AppointmentFailure) {
                return Center(child: Text(state.errorMessage));
              }
              else if (state is AppointmentSortSuccess) {
                return
                  Column(
                    children: [
                      doctorsRow(context, title: "All Doctors"),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: width * .025),
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = state.doctors[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: height * .02),
                            child: doctorContainer(
                              height,
                              width,
                              doctorID: doctor.id,
                              clinicName: doctor.clinics.first.clinicName,
                              doctorName: "${doctor.firstName} ${doctor.lastName}",
                              experience: doctor.experienceYears.toString(),
                              fees: doctor.defaultExaminationFee,
                              profilePicture: doctor.profilePicture,
                              clinicID: doctor.clinics.first.id,
                              context: context,
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(height: height * .01),
                      ),
                    ],
                  );
              }
              else if (state is AppointmentSuccess) {
                return
                  Column(
                    children: [
                      doctorsRow(context, title: "All Doctors"),
                      ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: width * .025),
                      itemCount: state.doctors.length,
                      itemBuilder: (context, index) {
                        final doctor = state.doctors[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: height * .02),
                          child: doctorContainer(
                            height,
                            width,
                            doctorID: doctor.id,
                            clinicName: doctor.clinics.first.clinicName,
                            doctorName: "${doctor.firstName} ${doctor.lastName}",
                            experience: doctor.experienceYears.toString(),
                            fees: doctor.defaultExaminationFee,
                            profilePicture: doctor.profilePicture,
                            clinicID: doctor.clinics.first.id,
                            context: context,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: height * .01),
                                        ),
                    ],
                  );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          ),
        ],
      ),
    );
  }


  Container doctorContainer(
    double height,
    double width, {
    required String clinicName,
    required String doctorName,
    required String experience,
    required int fees,
    required String profilePicture,
    required int doctorID,
    required int clinicID,
    required BuildContext context,
  }) {
    return Container(
      height: height * .22,
      width: width * .95,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .025),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profilePicture),
              radius: 46,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinicName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    doctorName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Experience Years : $experience Years",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Examination Fee : $fees EGP",
                    style: const TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorAppointmentScreen(
                              doctorId: doctorID, clinicId: clinicID),
                        ),
                      );
                    },
                    child: Container(
                      width: width,
                      height: height * .035,
                      decoration: BoxDecoration(
                        color: color7,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Make Appointment",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildWidget() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            Text(
              "Skintelligent",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget doctorsRow(BuildContext context,{
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          ),
          GestureDetector(
            child: Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                border: Border.all(color: Colors.black),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sort",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.filter_alt_rounded, size: 22),
                ],
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.sort_by_alpha),
                        title: const Text("From A to Z"),
                        onTap: () async {
                          await context.read<AppointmentCubit>().getAllDoctorsSortLocally("name", "asc");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.sort_by_alpha_outlined),
                        title: const Text("From Z to A"),
                        onTap: () async {
                          await context.read<AppointmentCubit>().getAllDoctorsSortLocally("name", "des");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.trending_up),
                        title: const Text("Highest Experience"),
                          onTap: () async {
                            await context.read<AppointmentCubit>().getAllDoctorsSortLocally("experience", "des");
                            Navigator.pop(context);
                          },
                      ),
                      ListTile(
                        leading: const Icon(Icons.trending_up),
                        title: const Text("Cost: Low -> High"),
                        onTap: () async {
                          await context.read<AppointmentCubit>().getAllDoctorsSortLocally("cost", "asc");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.trending_down),
                        title: const Text("Cost: High -> Low"),
                        onTap: () async {
                          await context.read<AppointmentCubit>().getAllDoctorsSortLocally("cost", "des");
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
