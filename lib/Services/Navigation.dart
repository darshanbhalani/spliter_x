import 'package:flutter/material.dart';

void callnextscreen(BuildContext context, StatefulWidget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void removeandcallnextscreen(BuildContext context, StatefulWidget screen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void pushAndRemoveUntil(BuildContext context, StatefulWidget screen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}
