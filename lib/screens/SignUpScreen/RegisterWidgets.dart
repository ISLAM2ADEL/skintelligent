import 'package:flutter/material.dart';

Widget buildInputField(IconData icon, String label, String texthint,
    {TextEditingController? controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF6D9BA6))),
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              hintText: texthint,
              filled: true,
              fillColor: Colors.grey.shade100,
              prefixIcon: Icon(icon, color: Color.fromARGB(255, 171, 225, 245)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
