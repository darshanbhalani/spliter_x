import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:spliter_x/Services/Conts.dart';
import 'package:spliter_x/Services/MemberModel.dart';
import 'package:spliter_x/Services/Navigation.dart';
import 'package:spliter_x/Services/Widgets.dart';
import 'package:spliter_x/Utils/toast.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key});

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  TextEditingController roomnamecontroller = TextEditingController();
  List<TextEditingController> membernamecontroller = [];
  List<TextEditingController> membermobilenocontroller = [];
  TextEditingController mobilenumnercontroller = TextEditingController();
  TextEditingController memberfirstnamecontroller = TextEditingController();
  TextEditingController memberlastnamecontroller = TextEditingController();
  List<Membermodel> memberlist = [];
  bool showTextField = false;
  bool showdatafield = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showprocessindicator(context);
      await Future.delayed(
        Duration(
          seconds: 2,
        ),
      );
      checkmobilenumner(
          FirebaseAuth.instance.currentUser!.phoneNumber.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgPrimary,
        title: Text('Add Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          children: [
            formField(
              context,
              'Enter Room Name',
              roomnamecontroller,
              true,
              TextInputType.name,
              onchange,
            ),
            if (showTextField)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListTile(
                      title: formField(
                        context,
                        'Enter Mobile Number',
                        mobilenumnercontroller,
                        true,
                        TextInputType.phone,
                        onchange,
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showprocessindicator(context);
                              if (mobilenumnercontroller.text.isEmpty) {
                                hindprocessindicator(context);
                                showtoast(context, 'Enter Mobile Number', 3);
                              } else {
                                checkmobilenumner(
                                    '+91${mobilenumnercontroller.text}');
                              }
                            });
                          },
                          child: Icon(
                            Icons.add,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (showdatafield)
              Container(
                color: Colors.red,
                child: Column(
                  children: [
                    formField(
                      context,
                      'Enter First Name',
                      memberfirstnamecontroller,
                      true,
                      TextInputType.name,
                      onchange,
                    ),
                    formField(
                      context,
                      'Enter Last Name',
                      memberlastnamecontroller,
                      true,
                      TextInputType.name,
                      onchange,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  showdatafield = !showdatafield;
                                  showTextField = !showTextField;
                                  mobilenumnercontroller.text = '';
                                });
                              },
                              child: Container(
                                width: screenwidth,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: InkWell(
                              onTap: () async {
                                if (memberfirstnamecontroller.text.isNotEmpty &&
                                    memberlastnamecontroller.text.isNotEmpty) {
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc('+91${mobilenumnercontroller.text}')
                                      .set(
                                    {
                                      'firstName':
                                          memberfirstnamecontroller.text,
                                      'lastName': memberlastnamecontroller.text,
                                      'gender': '',
                                      'joinningDate': DateTime.now(),
                                      'phoneNumber':
                                          '+91${mobilenumnercontroller.text}',
                                      'rooms': [],
                                    },
                                  ).whenComplete(
                                    () {
                                      var data = Membermodel(
                                        photoUrl: '',
                                        name:
                                            '${memberfirstnamecontroller.text} ${memberlastnamecontroller.text}',
                                        number:
                                            '+91${mobilenumnercontroller.text}',
                                      );
                                      memberlist.add(data);
                                      showtoast(
                                          context, 'Meber add successfully', 5);
                                      setState(() {
                                        showdatafield = !showdatafield;
                                        showTextField = !showTextField;
                                      });
                                    },
                                  );
                                } else {
                                  showtoast(context, 'Please Enter Name', 5);
                                }
                              },
                              child: Container(
                                width: screenwidth,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: memberlist.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.red,
                          child: ListTile(
                            title: Text(memberlist[index].name.toString()),
                            subtitle: Text(memberlist[index].number.toString()),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SwipeActionCell(
                      key: ValueKey(memberlist[index]),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.red,
                            child: ListTile(
                              title: Text(memberlist[index].name.toString()),
                              subtitle:
                                  Text(memberlist[index].number.toString()),
                            ),
                          ),
                        ],
                      ),
                      trailingActions: [
                        SwipeAction(
                            title: "Remove",
                            performsFirstActionWithFullSwipe: true,
                            // nestedAction: SwipeNestedAction(title: "confirm"),
                            onTap: (handler) async {
                              await handler(true);
                              memberlist.removeAt(index);
                              setState(() {});
                            }),
                      ],
                    );
                  }
                },
              ),
            ),
            GestureDetector(
              onTap: () async {
                createroom();
              },
              child: buttonwidget(
                context,
                'Create Room',
                bgSecondry1,
                bgSecondry2,
                Colors.white,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            setState(() {
              showTextField = !showTextField;
            });
          },
          child: Container(
            width: screenwidth * 0.13,
            height: screenheight * 0.06,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(
                100,
              ),
            ),
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void onchange(String value) {
    // Perform any actions you want with the changed text
    print("Text changed: $value");
  }

  Future checkmobilenumner(String id) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .get()
        .then((DocumentSnapshot snapshot) async {
      if (snapshot.exists) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(id)
            .get()
            .then((DocumentSnapshot snapshot) {
          var data = Membermodel(
            photoUrl: '',
            name: '${snapshot['firstName']} ${snapshot['lastName']}',
            number: id,
          );
          if (memberlist.isNotEmpty) {
            bool userAlreadyAdded = false;
            for (int i = 0; i < memberlist.length; i++) {
              print(i);
              if (memberlist[i].number == data.number) {
                print('enterd in else...');
                userAlreadyAdded = true;
              }
              mobilenumnercontroller.text = '';
            }
            if (userAlreadyAdded == true) {
              showtoast(context, 'Already added...', 5);
              hindprocessindicator(context);
              mobilenumnercontroller.text = '';
              // showdatafield = !showdatafield;
            } else {
              memberlist.add(data);
              hindprocessindicator(context);
            }
            setState(() {
              showTextField = !showTextField;
            });
          } else {
            memberlist.add(data);
            setState(() {});
            hindprocessindicator(context);
            return;
          }
        });
      } else {
        print('user does not exits....');
        showdatafield = !showdatafield;
        hindprocessindicator(context);

        setState(() {});
      }
    });
  }

  Future createroom() async {
    if (roomnamecontroller.text.isNotEmpty && memberlist.length >= 2) {
      showprocessindicator(context);
      List<String> roomMates = [];
      for (int i = 0; i < memberlist.length; i++) {
        roomMates.add(memberlist[i].number.toString());
      }
      await FirebaseFirestore.instance.collection('Rooms').doc().get().then(
        (DocumentSnapshot snapshot) async {
          await FirebaseFirestore.instance
              .collection('Rooms')
              .doc(snapshot.id)
              .set({
            'creationTime': DateTime.now(),
            'roomId': snapshot.id,
            'roomMates': roomMates,
            'roomName': roomnamecontroller.text,
            'roomTranscations': {}
          }).whenComplete(
            () {
              hindprocessindicator(context);
              Navigator.of(context).pop();
            },
          );
        },
      );
    } else if (roomnamecontroller.text.isEmpty) {
      showtoast(context, 'Enter Room Name', 3);
    } else {
      showtoast(context, 'Add Room Member', 3);
    }
  }
}
