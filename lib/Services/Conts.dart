import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color bgPrimary = Color.fromARGB(255, 21, 20, 77);
Color bgSecondry1 = Color.fromARGB(255, 201, 29, 141);
Color bgSecondry2 = Color.fromARGB(255, 248, 140, 41);

var fire = FirebaseFirestore.instance;
var auth = FirebaseAuth.instance;

List<String> monthNames = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];
