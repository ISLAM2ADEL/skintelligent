import 'package:skintelligent/commons.dart';
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
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            String page = cubit.getPage();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("${path}photo($page).png"),
                SizedBox(
                  height: height * .025,
                ),
                Text(
                  page == '1'
                      ? boldText1
                      : page == '2'
                          ? boldText2
                          : boldText3,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                SizedBox(
                  width: width * .85,
                  child: Text(
                    textAlign: TextAlign.center,
                    page == '1'
                        ? normalText1
                        : page == '2'
                            ? normalText2
                            : normalText3,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
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
                    },
                  ),
                  Row(
                    children: [
                      page == '1' ? chosenPage() : unchosenPage(),
                      SizedBox(
                        width: width * .02,
                      ),
                      page == '2' ? chosenPage() : unchosenPage(),
                      SizedBox(
                        width: width * .02,
                      ),
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

                      page== '3' ? cubit.loginPage(): cubit.nextPage();
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
