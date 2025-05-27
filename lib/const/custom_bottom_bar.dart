import 'package:flutter/material.dart';
import 'package:skintelligent/screens/ChatbotScrean/chatbotScreen.dart';
import 'package:skintelligent/screens/home_screen/home_page.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/screens/user_booking_screen/user_booking_screen.dart';
import 'const.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BottomAppBar(
      height: height * .115,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: color6,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: buildIcon(
                  icons: Icons.home,
                ),
                onTap: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
              ),
              InkWell(
                child: buildIcon(
                  icons: Icons.calendar_month_outlined,
                ),
                onTap: () {
                  Navigator.pushNamed(context, UserBookingScreen.id);
                },
              ),
              InkWell(
                child: buildIcon(
                  icons: Icons.chat,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Chatbotscreen.id);
                },
              ),
              InkWell(
                child: buildIcon(
                  icons: Icons.person,
                ),
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Icon buildIcon({required IconData icons}) {
    return Icon(
      icons,
      color: Colors.white,
      size: 44,
    );
  }
}
