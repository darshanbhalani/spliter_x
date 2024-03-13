import 'package:flutter/material.dart';
import 'package:rive/rive.dart' show RiveAnimation;
import 'package:spliter_x/Services/Conts.dart';
import 'package:spliter_x/Services/Widgets.dart';
import 'package:spliter_x/Services/otpservice.dart';
import 'package:spliter_x/Utils/toast.dart';

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
      backgroundColor: const Color.fromARGB(255, 10, 0, 40),
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
                    colors: [bgSecondry2, bgSecondry1],
                  ).createShader(bounds);
                },
                child: Text("Phone Verification",
                    style: TextStyle(
                        color: bgSecondry1,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("We need to verify you phone before getting started!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              const SizedBox(
                height: 15,
              ),
              formField(context, "Phone No.", controller, true,
                  TextInputType.number, onchange),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (controller.text.length == 10) {
                    print('controller have only number');
                    phonenumber = '+91${controller.text}';
                    showprocessindicator(context);
                    await OTPService.verifyphonenumber(context, phonenumber);
                  } else {
                    showtoast(context, 'please Enter Valid Number', 3);
                  }
                },
                child: buttonwidget(
                  context,
                  'Send OTP',
                  bgSecondry1,
                  bgSecondry2,
                  Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onchange(String value) {
    print("Text changed: $value");
  }
}
