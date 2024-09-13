import 'dart:io';

import 'package:baatchit/model/chat_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageController extends ChangeNotifier {
  // storage instance
  final event = FirebaseDatabase.instance.ref("maingroup");
  final _storage = FirebaseStorage.instance;

  Future<String?> uploadFile(File image) async {
    String? url;
    try {
      final fileName = image.path.split("/").last; // "IMG12482.jpg"
      final reff = _storage.ref("UserImage/$fileName");
      await reff.putFile(image);
      final url = await reff.getDownloadURL();

      await event.push().set(ChatModel(images: url).tomsg());
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return url;
  }

  uploadMedia(List<File> images) async {
    try {
      for (var img in images) {
        final url = await uploadFile(img);
        if (url != null) {
          // TODO; SAVE THIS URL AS PER YOUR REQUIRMENTS
        }
      }
    } catch (e) {}
  }
}
