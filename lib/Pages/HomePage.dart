import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spliter_x/Pages/AddRoomPage.dart';
import 'package:spliter_x/Pages/LoginPage.dart';
import 'package:spliter_x/Pages/ProfilePage.dart';
import 'package:spliter_x/Pages/RoomPage.dart';
import 'package:spliter_x/Services/Conts.dart';
import 'package:spliter_x/Services/Navigation.dart';
import 'package:spliter_x/Services/Widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    phonenumber = FirebaseAuth.instance.currentUser!.phoneNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 100,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text('data'),
          //       );
          //     },
          //   ),
          // ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Rooms')
                .where('roomMates', arrayContains: phonenumber)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: ListView(
                  children: snapshot.data!.docs.map((snap) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RoomPage(
                                    roomId: snap['roomId'],
                                    roomName: snap['roomName'])));
                      },
                      child: ListTile(
                        tileColor: Colors.red,
                        title: Text(snap["roomName"]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.group),
                            SizedBox(
                              width: 10,
                            ),
                            Text(snap['roomMates'].length.toString()),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
