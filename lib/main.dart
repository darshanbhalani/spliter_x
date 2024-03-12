import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spliter_x/Pages/HomePage.dart';
import 'package:spliter_x/Pages/HomeScreenView.dart';
import 'package:spliter_x/Pages/LoginPage.dart';
import 'package:spliter_x/Pages/SplashScreenPage.dart';
import 'package:spliter_x/Services/Conts.dart';
import 'package:spliter_x/Services/Navigation.dart';
import 'package:spliter_x/Services/Widgets.dart';
import 'package:spliter_x/Utils/sharedpreference.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    size.screensize(context);
    return MaterialApp(
      title: 'Spliter X',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: (FirebaseAuth.instance.currentUser != null)
          ? HomeScreenView()
          : LoginPage(),
    );
  }
}
