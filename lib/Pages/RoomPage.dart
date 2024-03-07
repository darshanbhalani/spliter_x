import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spliter_x/Services/Conts.dart';

class RoomPage extends StatefulWidget {
  final String roomId;
  final String roomName;
  const RoomPage({super.key,required this.roomId,required this.roomName});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Rooms').where('roomId',isEqualTo: widget.roomId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((snap) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: bgSecondry2,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text(snap['roomMates']),
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
