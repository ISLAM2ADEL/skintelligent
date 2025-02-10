import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/authentication/auth_Screens/auth_loginScreen.dart';
import 'package:skintelligent/const/const.dart';
import 'package:skintelligent/cubit/onboarding_cubit/onboarding_cubit.dart';
import 'package:get/get.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: height * .08,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.all(width * .065),
            child: InkWell(
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Get.offAll(const LoginScreen());
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return PageView(
            controller: cubit.pageController,
            onPageChanged: (index) {
              cubit.updatePage(index + 1); // Update the page in the cubit
            },
            children: [
              _buildOnboardingPage(context, '1', boldText1, normalText1),
              _buildOnboardingPage(context, '2', boldText2, normalText2),
              _buildOnboardingPage(context, '3', boldText3, normalText3),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: height * .08,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: width * .025, right: width * .025),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              String page = cubit.getPage();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      page == '1' ? "" : "Back",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      cubit.previousPage();
                      cubit.pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  Row(
                    children: [
                      page == '1' ? chosenPage() : unchosenPage(),
                      SizedBox(width: width * .02),
                      page == '2' ? chosenPage() : unchosenPage(),
                      SizedBox(width: width * .02),
                      page == '3' ? chosenPage() : unchosenPage(),
                    ],
                  ),
                  InkWell(
                    child: Text(
                      page == '3' ? "Start" : "Next",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      if (page == '3') {
                        cubit.loginPage();
                      } else {
                        cubit.nextPage();
                        cubit.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(
    BuildContext context,
    String page,
    String boldText,
    String normalText,
  ) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("${path}photo($page).png"),
        SizedBox(height: height * .025),
        Text(
          boldText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * .02),
        SizedBox(
          width: MediaQuery.of(context).size.width * .85,
          child: Text(
            textAlign: TextAlign.center,
            normalText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  CircleAvatar unchosenPage() {
    return const CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 7,
    );
  }

  Container chosenPage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(40),
      ),
      width: 25,
      height: 12,
    );
  }
}
