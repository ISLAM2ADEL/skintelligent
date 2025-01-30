import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/constants_images_path.dart';

class LanguagesDropDown extends StatefulWidget {
  const LanguagesDropDown({super.key});

  @override
  State<LanguagesDropDown> createState() => _LanguagesDropDownState();
}

class _LanguagesDropDownState extends State<LanguagesDropDown> {
  String selectedItem = kUkFlagImagePath; // Default selected flag

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 40, // Adjust container height
            width: 115, // Adjust container width
            decoration: BoxDecoration(
              color: const Color(0xfff9fafc),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: DropdownButton<String>(
                value: selectedItem,
                underline: const SizedBox.shrink(), // Remove the underline
                items: [
                  {
                    'path': kUkFlagImagePath,
                    'label': 'EN',
                  },
                  {
                    'path': kArabFlagImagePath,
                    'label': 'AR',
                  }
                ].map((language) {
                  return DropdownMenuItem<String>(
                    value: language['path'],
                    child: Row(
                      children: [
                        Image.asset(
                          language['path']!,
                          height: 30, // Adjust image height
                          width: 30, // Adjust image width
                        ),
                        const SizedBox(width: 8), // Space between flag and text
                        Text(language['label']! , style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
