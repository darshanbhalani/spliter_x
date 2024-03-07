import 'package:flutter/material.dart';
import 'package:rive/rive.dart' show RiveAnimation;
import 'package:spliter_x/Pages/HomePage.dart';
import 'package:spliter_x/Services/Conts.dart';
import 'package:spliter_x/Services/Widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 10, 0, 40),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 250,
                width: 250,
                child: RiveAnimation.asset("assets/animation.riv"),
              ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ bgSecondry2,bgSecondry1],
              ).createShader(bounds);
            },
            child:Text("Phone Verification",style: TextStyle(color: bgSecondry1,fontSize: 30,fontWeight: FontWeight.bold)),
          ),
              const SizedBox(height: 5,),
              const Text("We need to verify you phone before getting started!",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15)),
              const SizedBox(height: 15,),
              formField(context, "Phone No.", controller, true),
              const SizedBox(height: 20,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient:  LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [bgSecondry1, bgSecondry2],
                    ),
                  borderRadius: BorderRadius.circular(3)
                ),
                child:  GestureDetector(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()),(route) => false,);
                  },
                    child: const Center(child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
