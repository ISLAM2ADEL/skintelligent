import 'package:skintelligent/commons.dart';

import '../../const/const.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String id = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cubit = context.read<SplashCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            cubit.navigateAfterDelay();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome to",
                  style: TextStyle(
                    color: color1,
                    fontSize: 38,
                  ),
                ),
                Image.asset(
                  "${path}skintelligent.png",
                  width: width * .85,
                ),
                Image.asset(
                  "${path}doctor.png",
                  width: width * .9,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
