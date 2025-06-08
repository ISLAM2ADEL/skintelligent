import 'package:flutter/cupertino.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';
import 'package:skintelligent/screens/user_booking_screen/user_booking_screen.dart';
import 'package:skintelligent/widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  static const String id = 'ProfileScreen';

  final List<Color> colorPalitte = [
    Colors.green,
    Colors.orange, // لون جديد للحجوزات
  ];

  final List<IconData> iconPalitte = [
    CupertinoIcons.person_crop_circle_fill,
    Icons.calendar_today, // أيقونة للحجوزات
  ];

  final List<String> title = [
    "Personal Information",
    "My Bookings",
  ];

  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context)?.settings.arguments as String?;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Container(
                  alignment: Alignment.center, child: const Text("Profile")),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: iconPalitte.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: CustomListTile(
                        title: title[index],
                        listTileColor: colorPalitte[index],
                        primaryIcon: iconPalitte[index],
                      ),
                      onTap: () {
                        if (index == 1) {
                          Navigator.pushNamed(context, UserBookingScreen.id);
                        } else {
                          Navigator.pushNamed(context, Registerscreen.id);
                        }
                      },
                    );
                  },
                ),
              ),
              const LogoutButton(),
            ],
          ),
        );
      },
    );
  }
}
