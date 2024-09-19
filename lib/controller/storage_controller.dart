import 'dart:io';

import 'package:baatchit/model/chat_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageController extends ChangeNotifier {
  // storage instance
  final _storage = FirebaseStorage.instance;
  // realtime instance
  final event = FirebaseDatabase.instance.ref("maingroup");

  // final _picker = ImagePicker();

  Future<String?> uploadFile(File image,
      {TextEditingController? msg, String? path}) async {
    String? url;
    try {
      final fileName = image.path.split("/").last;
      final reff = _storage.ref(path ?? "maingroupImage/$fileName");
      await reff.putFile(image);
      final url = await reff.getDownloadURL();
      await event.push().set(ChatModel(image: url, message: msg!.text).tomsg());
      msg.clear();

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return url;
  }

  void replaceImage(String imagePath, File newImage, String msgId) async {
    // imagePath = "firebase_storagePath.come/photos/7H698679Y9.jpg"

    try {
      final imageName = imagePath.split("/").last;
      final url = uploadFile(newImage, path: "Photos/$imageName");
      event.child(msgId).update(ChatModel(image: await url).tomsg());
    } catch (e) {
      rethrow;
    }
  }

  void removeImage(String path) async {
    try {
      final imageReff = _storage.ref(path);
      await imageReff.delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
