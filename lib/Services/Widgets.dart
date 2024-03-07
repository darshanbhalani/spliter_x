import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spliter_x/Services/Conts.dart'; // Import your constants

Widget formField(BuildContext context, String label, TextEditingController controller, bool condition) {
  return Column(
    children: [
      SizedBox(
        height: 50,
        child: TextFormField(
          cursorColor: bgSecondry2,
          controller: controller,
          enabled: condition,
          keyboardType: label == "Phone No." ? TextInputType.number : TextInputType.text,
          validator: (value) {
            if (label == "Phone No." && controller.text.length != 10) {
              return "Please Enter Valid $label";
            } else if (label == "OTP" && controller.text.length != 6) {
              return "Please Enter Valid $label";
            } else if (controller.text.isEmpty) {
              return "Please Enter $label";
            }
            return null;
          },
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: bgSecondry2),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: bgSecondry2, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: bgSecondry2, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            labelText: label,
            labelStyle: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          inputFormatters: label == "Phone No."
              ? [
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.digitsOnly,
          ]
              : label == "OTP"
              ? [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.digitsOnly,
          ]
              : [],
        ),
      ),
      const SizedBox(height: 15),
    ],
  );
}
