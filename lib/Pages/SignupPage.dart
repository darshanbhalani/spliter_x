import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spliter_x/Pages/HomeScreenView.dart';
import 'package:spliter_x/Services/Conts.dart';
import 'package:spliter_x/Services/Navigation.dart';
import 'package:spliter_x/Services/Widgets.dart';
import 'package:spliter_x/Utils/toast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController gendercontrolller = TextEditingController(text: "Male");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'Sign Up',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            formField(context, 'Enter First Name', firstnamecontroller, true,
                TextInputType.name, onchange),
            formField(context, 'Enter Last Name', lastnamecontroller, true,
                TextInputType.name, onchange),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(
                  4,
                ),
              ),
              width: screenwidth,
              child: DropdownButton<String>(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                dropdownColor: bgSecondry2,
                value: gendercontrolller.text, // Initially selected value
                onChanged: (value) {
                  setState(() {
                    gendercontrolller.text = value!;
                  });
                },
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.centerLeft,
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child:
                  Container(), // Empty Container to push buttonwidget to bottom
            ),
            InkWell(
              onTap: () {
                showprocessindicator(context);
                if (firstnamecontroller.text.isNotEmpty &&
                    lastnamecontroller.text.isNotEmpty &&
                    gendercontrolller.text.isNotEmpty) {
                  adduserdata();
                } else {
                  if (firstnamecontroller.text.isEmpty &&
                      lastnamecontroller.text.isEmpty) {
                    showtoast(context, 'Please Enter details', 3);
                    hindprocessindicator(context);
                  } else if (firstnamecontroller.text.isEmpty &&
                      lastnamecontroller.text.isNotEmpty) {
                    showtoast(context, 'Please Enter FirstName', 5);
                    hindprocessindicator(context);
                  } else if (lastnamecontroller.text.isEmpty &&
                      firstnamecontroller.text.isNotEmpty) {
                    showtoast(context, 'Please Enter LastName', 5);
                    hindprocessindicator(context);
                  }
                }
              },
              child: buttonwidget(
                context,
                'Sign Up',
                bgSecondry1,
                bgSecondry2,
                Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future adduserdata() async {
    await FirebaseFirestore.instance.collection('Users').doc(phonenumber).set({
      'firstName': firstnamecontroller.text,
      'lastName': lastnamecontroller.text,
      'joinningDate': DateTime.now(),
      'gender': gendercontrolller.text,
      'phoneNumber': phonenumber,
      'rooms': []
    }).then(
      (value) async {
        await Future.delayed(
          Duration(
            seconds: 2,
          ),
        );
        hindprocessindicator(context);
        pushAndRemoveUntil(
          context,
          HomeScreenView(),
        );
      },
    ).whenComplete(
      () async {
        List<String> roomid = [];
        await FirebaseFirestore.instance
            .collection('Rooms')
            .where('roomMates', arrayContains: phonenumber)
            .get()
            .then(
          (QuerySnapshot snapshot) async {
            snapshot.docs.forEach(
              (element) async {
                roomid.add(element.id);
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(phonenumber)
                    .update(
                  {
                    'rooms': roomid,
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void onchange(String controller) {
    print(controller);
  }
}
