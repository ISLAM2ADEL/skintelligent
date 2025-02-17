import 'package:flutter/material.dart';

Widget buildOptionButton(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: BorderSide(
            color: const Color.fromARGB(255, 135, 200, 253), width: 1),
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text, textAlign: TextAlign.center),
    ),
  );
}
