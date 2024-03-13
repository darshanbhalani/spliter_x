import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spliter_x/Pages/OtpScreen.dart';
import 'package:spliter_x/Services/Navigation.dart';
import 'package:spliter_x/Utils/toast.dart';

class OTPService {
  static String id = '';
  static Future<dynamic> verifyphonenumber(
      BuildContext context, String phonenumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        id = verificationId.toString();
        print(id);
        Navigator.of(context).pop();
        callnextscreen(
          context,
          OtpScreen(),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        id = verificationId.toString();
      },
    );
  }

  static Future<User?> verifyotp(BuildContext context, String otp) async {
    try {
      PhoneAuthCredential userCredential = PhoneAuthProvider.credential(
          verificationId: id.toString(), smsCode: otp);
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(userCredential);
      if (user.user != null) {
        return user.user;
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-verification-code':
            showtoast(context,
                'Invalid OTP. Please enter a valid verification code.', 5);
            break;
          case 'too-many-requests':
            showtoast(context,
                'Too many verification requests. Please try again later.', 5);
            break;
          case 'session-expired':
            showtoast(
                context,
                'Verification session expired. Please restart the verification process.',
                5);
            break;
          case 'quota-exceeded':
            showtoast(context, 'Quota exceeded. Please try again later.', 5);
            break;
          case 'internal-error':
            showtoast(
                context, 'Internal error occurred. Please try again later.', 5);
            break;
          case 'invalid-phone-number':
            showtoast(context,
                'Invalid phone number. Please enter a valid phone number.', 5);
            break;
          case 'missing-client-identifier':
            showtoast(
                context,
                'Missing client identifier. Please check your Firebase project configuration.',
                5);
            break;
          case 'app-not-authorized':
            showtoast(context,
                'App not authorized to use Firebase Authentication.', 5);
            break;
          case 'user-disabled':
            showtoast(
                context, 'User account disabled. Please contact support.', 5);
            break;
          case 'network-request-failed':
            showtoast(
                context,
                'Network request failed. Please check your internet connection.',
                5);
            break;
          default:
            print('Unhandled error: ${e.code}');
            break;
        }
        Navigator.of(context).pop();
      } else {
        print('Error: $e');
      }
    }
  }
}
