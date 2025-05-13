import 'package:flutter/material.dart';

class SubmittButton extends StatelessWidget {
  const SubmittButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}