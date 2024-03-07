import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:spliter_x/Pages/RoomPage.dart';
import 'package:spliter_x/Services/Conts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spliter X", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: bgPrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(Icons.more_vert_outlined),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Rooms').where('roomMates',arrayContains: '+919909343073')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((snap) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RoomPage(roomId: snap['roomId'], roomName: snap['roomName'])));
                },
                child: ListTile(
                  tileColor: Colors.red,
                  title: Text(snap["roomName"]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.group),
                      SizedBox(width: 10,),
                      Text(snap['roomMates'].length.toString()),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

