import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants_Colors/Constants_color.dart';

class Customtextbutton extends StatelessWidget {
   Customtextbutton({super.key , required this.position , required this.text});

 String text ;
MainAxisAlignment  position ;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: position ,
      children: [
        TextButton(onPressed: (){}, child:  Text(text , style:const  TextStyle(color: kMySecondaryColor) ,)),
      ],
    ) ;
  }
}
