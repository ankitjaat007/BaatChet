import 'package:baatchit/model/chat_model.dart';
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
  final event = FirebaseDatabase.instance.ref("AnkitChats");
  List<ChatModel> _allMsg = [];
  List<ChatModel> get allMsg => _allMsg;

// add msg on firebase me
  Future<void> sendMsg(TextEditingController msgController) async {
    try {
      if (msgController.text.trim().isEmpty) return;
      await event.push().set(ChatModel(message: msgController.text).tomsg());
      msgController.clear();
    } catch (e) {
      rethrow;
    }
  }

// fatch all msg on firebase those added new
  fatchMsg() {
    try {
      event.onChildAdded.listen((data) {
        final msg = data.snapshot.value as Map;
        final id = data.snapshot.key.toString();
        final aa = ChatModel.fromchat(msg, id);

        _allMsg.add(aa);
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

// ********************************
// *******

// fatch all msg on firebase those updated new
  FatchUpdateData() {
    try {
      event.onChildChanged.listen((data) {
        final msg = data.snapshot.value as Map;
        final id = data.snapshot.key.toString();
        final aa = ChatModel.fromchat(msg, id);
        final index = _allMsg.indexWhere(
          (element) => element.msgId == id,
        );
        _allMsg[index] = aa;
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

// update msg for me
  updateMsg(TextEditingController msgController, String msgId) {
    try {
      if (msgController.text.trim().isEmpty) return;
      event.child(msgId).update(ChatModel(message: msgController.text).tomsg());
    } catch (e) {
      rethrow;
    }
  }

  // *****************************
  // *******
}
