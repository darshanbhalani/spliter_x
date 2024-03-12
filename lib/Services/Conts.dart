// ----------------color Scheme--------------------------

import 'package:flutter/material.dart';

Color bgPrimary = Color.fromARGB(255, 21, 20, 77);
Color backgroundColor = Color.fromARGB(255, 10, 0, 40);
Color bgSecondry1 = Color.fromARGB(255, 201, 29, 141);
Color bgSecondry2 = Color.fromARGB(255, 248, 140, 41);
Color whitecolor = Colors.white;

double screenwidth = 0;
double screenheight = 0;
String phonenumber='';

class size {
  static screensize(context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
  }
}

