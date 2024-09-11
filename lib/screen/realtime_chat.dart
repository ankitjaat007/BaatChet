import 'package:baatchit/components/showbottomSheet.dart';
import 'package:baatchit/controller/firebase_controller.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RealtimeChat extends StatelessWidget {
  RealtimeChat({super.key});

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatController>(context);
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
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  provider
                                      .removemsg(chat[index].msgId.toString());
                                  Navigator.pop(ctx);
                                },
                                child: const Text("delete"))
                          ],
                        ),
                      ),
                    );
                  },
                  child: Chip(
                    label: Text(chat[index].message.toString()),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Chip(
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(chat[index].message.toString()),
                        Text(
                          chat[index].message.toString(),
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey),
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
                    onPressed: () => provider.sendMsg(messageController),
                    icon: const Icon(Icons.keyboard_double_arrow_right_sharp)),
              )
            ],
          ),
        ),
      ),
    );
  }

//   Future<void> _sendMsg() async {
//     final message = messageController.text;
//     if (message.trim().isEmpty) return;
//     await FirebaseDatabase.instance
//         .ref("AnkitChats")
//         .push()
//         .set(ChatModel(message: message).tomsg());
//     messageController.clear();
//   }
}
