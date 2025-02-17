import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/screens/qr_code/qr_code.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  static const String id = 'ProfileScreen';

  final List<Color> colorPalitte = [
    Colors.green,
    Colors.lightBlue,
    Colors.blue,
    Colors.grey,
  ];

  final List<IconData> iconPalitte = [
    CupertinoIcons.person_crop_circle_fill,
    Icons.notifications,
    Icons.language,
    CupertinoIcons.trash_fill,
  ];

  final List<String> title = [
    "Personal Information",
    "Notification",
    "Change Language",
    "Delete Account "
  ];

  @override
  Widget build(BuildContext context) {
    final String? scanResult =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Qrcode.id);
        },
        child: const Icon(
          Icons.qr_code_2,
          size: 40,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
              alignment: Alignment.center, child: const Text("Profile")),
        ),
      ),
      body: Column(
        children: [
          if (scanResult != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.black87,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Scanned QR Code:\n",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: scanResult,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.greenAccent),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: iconPalitte.length,
              itemBuilder: (context, index) {
                return CustomListTile(
                  title: title[index],
                  listTileColor: colorPalitte[index],
                  primaryIcon: iconPalitte[index],
                );
              },
            ),
          ),
          const LogoutButton(),
        ],
      ),
    );
  }
}
