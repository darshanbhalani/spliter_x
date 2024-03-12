import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spliter_x/Services/Conts.dart'; // Import your constants

Widget formField(
    BuildContext context,
    String label,
    TextEditingController controller,
    bool condition,
    TextInputType textInputType,
    Function(String) onchange) {
  return Column(
    children: [
      SizedBox(
        height: 50,
        child: TextFormField(
          cursorColor: bgSecondry2,
          onChanged: (value) {
            onchange(value);
          },
          // if (label == 'Phone No.') {
          //   print('Phone number is in onchange function in widgets.....');
          //   print(controller.text);
          // }
          controller: controller,
          enabled: condition,
          keyboardType: textInputType,
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
          inputFormatters:
              label == "Enter Mobile Number" || label == "Phone No."
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

Stack formfieldwithstack(BuildContext context, String label, String name,
    Function(String) onchange) {
  return Stack(
    alignment: Alignment.centerRight,
    children: [
      formField(context, label, TextEditingController(text: 'Gor'), false,
          TextInputType.name, onchange),
      Padding(
        padding: const EdgeInsets.only(
          right: 15,
          bottom: 13,
        ),
        child: Icon(
          Icons.edit,
          size: 21,
        ),
      ),
    ],
  );
}

Widget otptextformfield(
  BuildContext context,
  TextEditingController controller,
  bool bool,
  int count,
) {
  List<FocusNode> focusNodes = [
    FocusNode(debugLabel: '1'),
    FocusNode(debugLabel: '2'),
    FocusNode(debugLabel: '3'),
    FocusNode(debugLabel: '4'),
    FocusNode(debugLabel: '5'),
    FocusNode(debugLabel: '6'),
  ];
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        // focusNode: focusNodes[count],
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        controller: controller,
        // onEditingComplete: () {
        //   if (count < 5) {
        //     FocusScope.of(context).requestFocus(focusNodes[count + 1]);
        //   } else {
        //     FocusScope.of(context).unfocus();
        //   }
        // },
        decoration: InputDecoration(
          counter: Text(''),
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
          labelStyle: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        onTap: () {},
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    ),
  );
}

Widget buttonwidget(BuildContext context, String btntext, Color bgSecondry1,
    Color bgSecondry2, Color textcolor) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [bgSecondry1, bgSecondry2],
        ),
        borderRadius: BorderRadius.circular(3)),
    child: Center(
      child: Text(
        btntext,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

showprocessindicator(context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: bgSecondry1, // Background color
          valueColor: AlwaysStoppedAnimation<Color>(
            bgSecondry2, // Color at the center of the gradient
          ),
        ),
      );
    },
  );
}

hindprocessindicator(context) {
  return Navigator.pop(context);
}

Widget customListTile({
  required Widget title,
  required Widget leading,
  Widget? trailing,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          width: 72.0, // Adjust width as needed
          child: leading,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              if (trailing != null) SizedBox(height: 4.0),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ],
    ),
  );
}


// Widget elevatedbutton(BuildContext controller, String text,
//     Color backgroundColor, Color textcolor) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(
//       horizontal: 10,
//       vertical: 10,
//     ),
//     child: Container(
//       width: screenwidth,
//       height: screenheight * 0.057,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(
//           10,
//         ),
//         color: backgroundColor,
//       ),
//     ),
//   );
// }
