import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spliter_x/Pages/AddRoomPage.dart';
import 'package:spliter_x/Pages/HomePage.dart';
import 'package:spliter_x/Pages/LoginPage.dart';
import 'package:spliter_x/Pages/ProfilePage.dart';
import 'package:spliter_x/Services/Conts.dart';
import 'package:spliter_x/Services/Navigation.dart';
import 'package:spliter_x/Services/Widgets.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int index = 0;
  PageStorageBucket bucket = PageStorageBucket();
  final List screens = const [
    HomePage(),
    ProfilePage(),
  ];
  Widget currentScreen = const HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: (index == 0)
            ? Text("Spliter X", style: TextStyle(fontWeight: FontWeight.bold))
            : Text(
                'Profile',
              ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: InkWell(
                onTap: () async {
                  showprocessindicator(context);
                  await Future.delayed(
                    Duration(
                      seconds: 1,
                    ),
                  );
                  await FirebaseAuth.instance.signOut();
                  pushAndRemoveUntil(
                    context,
                    LoginPage(),
                  );
                },
                child: Icon(Icons.logout_outlined)),
          )
        ],
      ),
      body: screens[index],
      floatingActionButton: InkWell(
        onTap: () async {
          callnextscreen(
            context,
            AddRoomPage(),
          );
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: false,
        currentIndex: index,
        onTap: (index) {
          setState(() {
            print('index is in bottom navigation bar is....');
            print(index);
            this.index = index;
            setState(() {});
            currentScreen = screens[index];
          });
        },
        backgroundColor: backgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind),
              label: 'Profile',
              backgroundColor: Colors.orangeAccent),
        ],
      ),
    );
  }
}
