import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spliter_x/Pages/HomePage.dart';
import 'package:spliter_x/Pages/LoginPage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spliter X',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}


