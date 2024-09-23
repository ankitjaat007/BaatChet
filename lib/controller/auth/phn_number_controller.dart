import 'package:baatchit/authentication/phnNumber/otp_verify.dart';
import 'package:baatchit/controller/circleAvtar_controller.dart';
import 'package:baatchit/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhnNumberController {
  final _auth = FirebaseAuth.instance;
  String verificationId = "";
  Future<void> verifyPhoneNumber(String number, BuildContext context) async {
    final loder = Provider.of<CircularProgressIndicatorController>(context,
        listen: false);
    try {
      loder.setloding(true);
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91$number",
          verificationCompleted: (credentials) {
            //
          },
          verificationFailed: (FirebaseAuthException exception) {
            //
          },
          codeSent: (verificationid, code) {
            verificationId = verificationid;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OtpVerify()));
          },
          codeAutoRetrievalTimeout: (error) {
            //
          });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> verifyOtp(String otp, BuildContext ctx) async {
    print("verificationId :$verificationId");
    try {
      // final response =
      await _auth
          .signInWithCredential(
              AuthCredential(providerId: verificationId, signInMethod: otp))
          .then(
            (value) => Navigator.push(
                ctx, MaterialPageRoute(builder: (context) => HomeScreen())),
          );
      // final uid = response.user!.uid;
    } catch (e) {
      print(e.toString());
    }
  }
}
