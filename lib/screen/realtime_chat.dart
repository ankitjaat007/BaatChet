import 'dart:io';

import 'package:baatchit/components/imagePiker.dart';
import 'package:baatchit/components/showbottomSheet.dart';
import 'package:baatchit/controller/firebase_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/storage_controller.dart';

class RealtimeChat extends StatefulWidget {
  const RealtimeChat({super.key});

  @override
  State<RealtimeChat> createState() => _RealtimeChatState();
}

class _RealtimeChatState extends State<RealtimeChat> {
  final messageController = TextEditingController();

  // final _picker = ImagePicker();

  // final controller = StorageController();

  File? _image;
  File? _replaceImage;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatController>(context);
    final controller = Provider.of<StorageController>(context);
    final chat = provider.allMsg;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Group chat"),
      ),
      body: ListView.builder(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _replaceImage == null
                                ? SizedBox()
                                : Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(_replaceImage!))),
                                  ),
                            Wrap(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      voidfuncationClass().customBottomSheet(
                                          context,
                                          chat[index].msgId.toString(),
                                          chat[index].message.toString());
                                    },
                                    child: const Text("update msg")),
                                TextButton(
                                    onPressed: () async {
                                      final image = await getImageFormGallery();
                                      _replaceImage = File(image);
                                      setState(() {});
                                    },
                                    child: const Text("change img image")),
                                TextButton(
                                    onPressed: () {
                                      provider.removemsg(
                                          chat[index].msgId.toString());
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text("delete"))
                              ],
                            ),
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
                            ? const SizedBox()
                            : Text(chat[index].message.toString()),
                        chat[index].image == "" && chat[index].image == null
                            ? const SizedBox()
                            : CachedNetworkImage(
                                imageUrl: "${chat[index].image}",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(),
                              ),
                        // Image.network(
                        //     "${chat[index].image}",
                        //     height: 100,
                        //     width: 150,
                        //     fit: BoxFit.cover,
                        //   )
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
                            ? const SizedBox()
                            : Text(chat[index].message.toString()),
                        Text(
                          chat[index].sender.toString(),
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey),
                        ),
                        chat[index].image == ""
                            ? const SizedBox()
                            : CachedNetworkImage(
                                imageUrl: "${chat[index].image}",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(),
                              )
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image == null
                  ? const SizedBox()
                  : Stack(children: [
                      SizedBox(
                        height: 200,
                        width: 180,
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
                      IconButton(
                          onPressed: () {
                            _image = null;
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.red,
                          ))
                    ]),
              Row(
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
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                        )),
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                        onPressed: () async {
                          // final response = await _picker.pickImage(
                          //     source: ImageSource.camera);
                          // if (response != null) {
                          //   _image = File(response.path);
                          //   setState(() {});
                          // }
                          final image = await getImageFormCamra();
                          _image = File(image);
                          setState(() {});
                        },
                        icon: const Icon(Icons.camera_alt_outlined)),
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                        onPressed: () async {
                          final image = await getImageFormGallery();
                          _image = File(image);
                          setState(() {});
                        },
                        icon: const Icon(Icons.photo_album)),
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                        onPressed: () {
                          if (_image != null) {
                            controller
                                .uploadFile(_image!, msg: messageController)
                                .then(
                              (value) {
                                setState(() {
                                  _image = null;
                                });
                              },
                            );
                          } else {
                            provider.sendMsg(messageController);
                          }
                        },
                        icon: const Icon(
                            Icons.keyboard_double_arrow_right_sharp)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
