import 'package:flutter/material.dart';

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
              buildIcon(icons: Icons.home),
              buildIcon(icons: Icons.document_scanner),
              buildIcon(icons: Icons.chat),
              buildIcon(icons: Icons.person),
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
