import 'package:baatchit/model/user_model.dart';
import 'package:baatchit/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GmailPasswordController {
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance.collection("user");
  signup(Usermodel user, String password) async {
    try {
      final credintal = await _auth.createUserWithEmailAndPassword(
          email: user.email!, password: password);
      final uid = credintal.user!.uid;
      await db.add(user.tomap(uid));
      Utils.tostmsg("create account succes");
    } catch (e) {
      Utils.tostmsg(e.toString());
    }
  }

  login(Usermodel user, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: user.email!, password: password);
      Utils.tostmsg("login succes");
    } catch (e) {
      Utils.tostmsg(e.toString());
    }
  }
}
