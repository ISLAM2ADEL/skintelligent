import 'package:flutter/material.dart';
import 'package:skintelligent/const/const.dart';
import 'package:skintelligent/const/custom_bottom_bar.dart';
import 'package:skintelligent/const/custom_container.dart';

import 'confirm_appointment.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomBottomBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(
              height: height,
              widget: CustomContainer(
                height: height,
                widget: Padding(
                  padding:
                      EdgeInsets.only(left: width * .08, right: width * .08),
                  child: buildWidget(),
                ),
              ),
            ),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "SkinCo",
                clinicAddress: "Helwan",
                doctorName: "Mohammed Hanafy",
                experience: "7",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "PureSkin Center",
                clinicAddress: "Maadi",
                doctorName: "Mamdouh Fathallah",
                experience: "3",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "DermaCare Clinic",
                clinicAddress: "6 October",
                doctorName: "Marwan Sallam",
                experience: "5",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "SkinCo",
                clinicAddress: "Helwan",
                doctorName: "Mohammed Hanafy",
                experience: "7",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "PureSkin Center",
                clinicAddress: "Maadi",
                doctorName: "Mamdouh Fathallah",
                experience: "3",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "DermaCare Clinic",
                clinicAddress: "6 October",
                doctorName: "Marwan Sallam",
                experience: "5",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "SkinCo",
                clinicAddress: "Helwan",
                doctorName: "Mohammed Hanafy",
                experience: "7",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "PureSkin Center",
                clinicAddress: "Maadi",
                doctorName: "Mamdouh Fathallah",
                experience: "3",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "DermaCare Clinic",
                clinicAddress: "6 October",
                doctorName: "Marwan Sallam",
                experience: "5",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "SkinCo",
                clinicAddress: "Helwan",
                doctorName: "Mohammed Hanafy",
                experience: "7",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "PureSkin Center",
                clinicAddress: "Maadi",
                doctorName: "Mamdouh Fathallah",
                experience: "3",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "DermaCare Clinic",
                clinicAddress: "6 October",
                doctorName: "Marwan Sallam",
                experience: "5",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "SkinCo",
                clinicAddress: "Helwan",
                doctorName: "Mohammed Hanafy",
                experience: "7",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "PureSkin Center",
                clinicAddress: "Maadi",
                doctorName: "Mamdouh Fathallah",
                experience: "3",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "DermaCare Clinic",
                clinicAddress: "6 October",
                doctorName: "Marwan Sallam",
                experience: "5",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "SkinCo",
                clinicAddress: "Helwan",
                doctorName: "Mohammed Hanafy",
                experience: "7",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "PureSkin Center",
                clinicAddress: "Maadi",
                doctorName: "Mamdouh Fathallah",
                experience: "3",
                context: context),
            SizedBox(
              height: height * .025,
            ),
            doctorContainer(height, width,
                clinicName: "DermaCare Clinic",
                clinicAddress: "6 October",
                doctorName: "Marwan Sallam",
                experience: "5",
                context: context),
            SizedBox(
              height: height * .025,
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
    required String clinicAddress,
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
            const CircleAvatar(
              backgroundImage: AssetImage("${path}skin doctor.png"),
              radius: 45,
            ),
            const SizedBox(
              width: 7,
            ),
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
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$experience Years",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            width: 85,
                            height: 25,
                            decoration: BoxDecoration(
                                color: color7,
                                borderRadius: BorderRadius.circular(20.0)),
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
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmAppointment();
                                });
                          },
                        ),
                        const Spacer(),
                        Text(
                          clinicAddress,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
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
