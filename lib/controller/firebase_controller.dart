import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseController {
  final db = FirebaseDatabase.instance;

  // Future<void> postdata() async {
  //   try {
  //     await db.ref("user/123").set({"name": "ankit"});
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}

class ChatController extends ChangeNotifier {
  List<Map> _allMsg = [];

  List<Map> get allMsg => _allMsg;

  addMsg(DatabaseEvent event) {
    notifyListeners();
  }
}
