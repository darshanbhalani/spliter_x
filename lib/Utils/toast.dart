import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:spliter_x/Services/Conts.dart';

void showtoast(BuildContext context, String msg,int duration) {
  showToast(
    context: context,
    msg,
    backgroundColor: bgSecondry2,
    isHideKeyboard: true,
    duration: Duration(seconds: duration),
  );
}
