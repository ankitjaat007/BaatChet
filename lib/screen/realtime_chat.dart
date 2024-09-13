import 'dart:io';

import 'package:baatchit/components/showbottomSheet.dart';
import 'package:baatchit/controller/firebase_controller.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/storage_controller.dart';

class RealtimeChat extends StatefulWidget {
  RealtimeChat({super.key});

  @override
  State<RealtimeChat> createState() => _RealtimeChatState();
}

class _RealtimeChatState extends State<RealtimeChat> {
  final messageController = TextEditingController();

  final _picker = ImagePicker();

  // final controller = StorageController();

  File? _image;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatController>(context);
    final controller = Provider.of<StorageController>(context);
    final chat = provider.allMsg;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Group chat"),
      ),
      body: Column(
        children: [
          _image == null
              ? SizedBox()
              : Container(
                  height: 120,
                  width: double.infinity,
                  child: Image.file(_image!, fit: BoxFit.cover),
                ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              itemCount: chat.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: chat[index].sender == "ankit"
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    if (chat[index].sender == "ankit")
                      InkWell(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        voidfuncationClass().customBottomSheet(
                                            context,
                                            chat[index].msgId.toString(),
                                            chat[index].message.toString());
                                      },
                                      child: const Text("update")),
                                  TextButton(
                                      onPressed: () {
                                        provider.removemsg(
                                            chat[index].msgId.toString());
                                        Navigator.pop(ctx);
                                      },
                                      child: const Text("delete"))
                                ],
                              ),
                            ),
                          );
                        },
                        child: Chip(
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              chat[index].message == ""
                                  ? SizedBox()
                                  : Text(chat[index].message.toString()),
                              chat[index].images == ""
                                  ? SizedBox()
                                  : Image.network(
                                      "${chat[index].images}",
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                            ],
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Chip(
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              chat[index].message == ""
                                  ? SizedBox()
                                  : Text(chat[index].message.toString()),
                              Text(
                                chat[index].sender.toString(),
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.grey),
                              ),
                              chat[index].images == ""
                                  ? SizedBox()
                                  : Image.network(
                                      "${chat[index].images}",
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      prefixIconColor: Colors.black,
                      contentPadding: const EdgeInsets.all(0),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.emoji_emotions),
                      hintText: 'Message',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.white)),
                    )),
              ),
              const SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                child: IconButton(
                    onPressed: () async {
                      final response =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (response != null) {
                        _image = File(response.path);
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.attach_file_rounded)),
              ),
              const SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                child: IconButton(
                    onPressed: () {
                      // provider.sendMsg(messageController);
                      if (_image != null) controller.uploadFile(_image!);
                    },
                    icon: const Icon(Icons.keyboard_double_arrow_right_sharp)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
