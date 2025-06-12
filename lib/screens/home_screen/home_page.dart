import 'package:flutter/material.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/const/custom_bottom_bar.dart';
import 'package:skintelligent/const/custom_container.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_cubit.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_state.dart';
import 'package:skintelligent/screens/ChatbotScrean/chatbotScreen.dart';
import 'package:skintelligent/screens/appointment/appointment.dart';
import 'package:skintelligent/screens/patient_profile/patient_profile_screen.dart';
import 'package:skintelligent/screens/user_booking_screen/user_booking_screen.dart';
import '../../const/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Trigger the cubit method once when screen loads
    context.read<PatientProfileCubit>().getPatientProfile();
  }

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
              widget: Padding(
                padding: EdgeInsets.only(left: width * .08, right: width * .08),
                child: buildWidget(),
              ),
            ),
            SizedBox(height: height * .037),
            buildContainer(
                context: context,
                containerText: "Chat AI",
                containerImage: "chat image.png",
                containerColor: color1,
                width: width,
                height: height),
            SizedBox(height: height * .037),
            buildContainer(
                context: context,
                containerText: "Bookings",
                containerImage: "bookings.png",
                containerColor: color7,
                width: width,
                height: height),
            SizedBox(height: height * .037),
            buildContainer(
                context: context,
                containerText: "Appointment",
                containerImage: "annotation.png",
                containerColor: color3,
                width: width,
                height: height),
          ],
        ),
      ),
    );
  }

  Row buildWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
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
        BlocBuilder<PatientProfileCubit, PatientProfileState>(
          builder: (context, state) {
            Widget avatar;

            if (state is PatientProfileSuccess &&
                state.patientModel.profilePicture.isNotEmpty) {
              avatar = CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(state.patientModel.profilePicture),
              );
            } else {
              avatar = const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/default_image.png"),
              );
            }

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PatientProfileScreen.id);
                // OR: Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
              },
              child: avatar,
            );
          },
        )
      ],
    );
  }

  Widget buildContainer(
      {required String containerText,
      required String containerImage,
      required BuildContext context,
      required Color containerColor,
      required double width,
      required double height}) {
    return InkWell(
      child: Container(
        width: width * .9,
        height: height * .16,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                containerText,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                "$path$containerImage",
                width: 105,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        containerText == "Appointment"
            ? Navigator.pushNamed(context, Appointment.id)
            : containerText == "Bookings"
                ? Navigator.pushNamed(context, UserBookingScreen.id)
                : _showUpdateDialog();;
      },
    );
  }
  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Chat Bot AI'),
          content: const Text('You should book an appointment to open this feature'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
