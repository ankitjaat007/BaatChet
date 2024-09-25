import 'package:baatchit/authentication/phnNumber/otp_verify.dart';
import 'package:baatchit/controller/circularProgressIndicator_controller.dart';
import 'package:baatchit/model/user_model.dart';
import 'package:baatchit/screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String verificationId = "";

class PhnNumberController {
  final _auth = FirebaseAuth.instance;
  final _firebasefirestore = FirebaseFirestore.instance.collection("user");

  Future<void> verifyPhoneNumber(String number, BuildContext context) async {
    final loder = Provider.of<CircularProgressIndicatorController>(context,
        listen: false);
    try {
      loder.setloding(true);
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91$number",
          verificationCompleted: (credentials) {},
          verificationFailed: (FirebaseAuthException exception) {
            loder.setloding(false);
            //
          },
          codeSent: (verificationid, code) {
            verificationId = verificationid;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OtpVerify()));

            loder.setloding(false);
          },
          codeAutoRetrievalTimeout: (error) {});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> verifyOtp(String otp, BuildContext ctx) async {
    final loder =
        Provider.of<CircularProgressIndicatorController>(ctx, listen: false);
    // print(
    // "verificationId ************************************************* :$verificationId");
    try {
      loder.setloding(true);

      final creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await _auth.signInWithCredential(creds).then(
        (value) {
          final userdata = Usermodel().tomap(value.user!.uid);
          _firebasefirestore.add(userdata);
          Navigator.push(
              ctx, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );
    } catch (e) {
      print(e.toString());
    } finally {
      loder.setloding(false);
    }
  }
}
