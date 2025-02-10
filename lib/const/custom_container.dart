import 'package:flutter/material.dart';

import 'const.dart';

class CustomContainer extends StatelessWidget {
  final Widget widget;
  const CustomContainer({
    super.key,
    required this.height,
    required this.widget,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(
          90.0,
        ),
        bottomRight: Radius.circular(
          90.0,
        ),
      ),
      child: Container(
        height: height * .26,
        decoration: const BoxDecoration(
          color: color5,
        ),
        child: widget,
      ),
    );
  }
}
