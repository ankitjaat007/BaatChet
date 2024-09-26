import 'package:baatchit/authentication/gmail_and_password/verification_email.dart';
import 'package:baatchit/authentication/wrapper_screen.dart';
import 'package:baatchit/controller/circularProgressIndicator_controller.dart';
import 'package:baatchit/model/user_model.dart';
import 'package:baatchit/screen/home_screen.dart';
import 'package:baatchit/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GmailPasswordController {
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance.collection("user");
  signup(Usermodel user, String password, BuildContext context) async {
    final loder = Provider.of<CircularProgressIndicatorController>(context,
        listen: false);
    try {
      loder.setloding(true);

      final credintal = await _auth.createUserWithEmailAndPassword(
          email: user.email!, password: password);
      final uid = credintal.user!.uid;
      await db.add(user.tomap(uid));
      Utils.tostmsg("create account succes");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => VerificationEmail()));
    } catch (e) {
      Utils.tostmsg(e.toString());
    } finally {
      loder.setloding(false);
    }
  }

  login(Usermodel user, String password, BuildContext context) async {
    final loder = Provider.of<CircularProgressIndicatorController>(context,
        listen: false);
    try {
      loder.setloding(true);
      await _auth.signInWithEmailAndPassword(
          email: user.email!, password: password);
      Utils.tostmsg("login succes");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WrapperScreen()));
    } catch (e) {
      Utils.tostmsg(e.toString());
    } finally {
      loder.setloding(false);
    }
  }

  signout(BuildContext context, String userId) {
    try {
      _auth.signOut().then((value) {
        Utils.tostmsg("logOut succes");

        // db.doc(userId).delete();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WrapperScreen()),
            (route) => false);
      });
    } catch (e) {
      Utils.tostmsg(e.toString());
    }
  }

  Future<void> emailVerifiedLink() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      // Utils.tostmsg(e.toString());
      rethrow;
    }
  }
}
