import 'package:baatchit/controller/firebase_controller.dart';
import 'package:baatchit/model/chat_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RealtimeChat extends StatelessWidget {
  RealtimeChat({super.key});

  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ChatController>(context).allMsg;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Group chat"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            itemCount: chat.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: chat[index]['sender'] == "ankit"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  chat[index]['sender'] == "ankit"
                      ? Chip(
                          label: Text(chat[index]['message']),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Chip(
                            label: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(chat[index]['message']),
                                Text(
                                  chat[index]['sender'],
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
                    onPressed: _sendMsg,
                    icon: const Icon(Icons.keyboard_double_arrow_right_sharp)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendMsg() async {
    final message = messageController.text;
    if (message.trim().isEmpty) return;
    await FirebaseDatabase.instance
        .ref("maingroup")
        .push()
        .set(ChatModel(message: message).tomsg());
    messageController.clear();
  }
}
