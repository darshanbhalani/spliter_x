import 'package:flutter/material.dart';
import 'package:spliter_x/Services/Conts.dart';
import 'package:spliter_x/Services/Widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController firstNamecontroler = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController genderconttroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.red,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            formfieldwithstack(
                context, 'First Name', 'Gor',onchange),
            SizedBox(
              height: 10,
            ),
            formfieldwithstack(
                context, 'Last Name', 'Gor', onchange),
            SizedBox(
              height: 10,
            ),
            formfieldwithstack(
                context, 'Gender', 'Male', onchange),
          ],
        ),
      ),
    );
  }

  onchange(String p1) {}
}
