import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/const/const.dart';
import 'package:skintelligent/const/custom_bottom_bar.dart';
import 'package:skintelligent/const/custom_container.dart';
import 'package:skintelligent/screens/appointment/doctor_appointment_screen.dart';

import '../../commons.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});
  static const String id = 'Appointment';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) {
        final cubit = context.read<AppointmentCubit>();
        cubit.getAllDoctors(); // Fetch doctors on init
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const CustomBottomBar(),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            CustomContainer(
              height: height,
              widget: CustomContainer(
                height: height,
                widget: Padding(
                  padding: EdgeInsets.only(left: width * .08, right: width * .08),
                  child: buildWidget(),
                ),
              ),
            ),
            BlocBuilder<AppointmentCubit, AppointmentState>(
              builder: (context, state) {
                if (state is AppointmentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AppointmentFailure) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is AppointmentSuccess) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: width * .025),
                    itemCount: state.doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = state.doctors[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: height*.02),
                        child: doctorContainer(
                          height,
                          width,
                          doctorID: doctor.id.toString(),
                          clinicName:  "SkinCo",
                          doctorName: "${doctor.firstName} ${doctor.lastName}",
                          experience: doctor.experienceYears.toString(),
                          doctorPhone: doctor.phoneNumber,
                          profilePicture: doctor.profilePicture,
                          context: context,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(height: height * .025),
                  );
                } else {
                  return const Center(child: Text("No data available"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Container doctorContainer(
      double height,
      double width, {
        required String clinicName,
        required String doctorName,
        required String experience,
        required String doctorPhone,
        required String profilePicture,
        required String doctorID,
        required BuildContext context,
      }) {
    return Container(
      height: height * .17,
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
              //backgroundImage: NetworkImage(profilePicture),
              backgroundImage: NetworkImage("https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D "),
              radius: 45,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clinicName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * .45,
                          child: Text(
                            doctorName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$experience Years",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            print(doctorID);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 85,
                            height: 25,
                            decoration: BoxDecoration(
                              color: color7,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Center(
                              child: Text(
                                "Appointment",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          doctorPhone,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
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
        Icon(
          Icons.notifications_none_rounded,
          size: 32,
        ),
      ],
    );
  }
}
