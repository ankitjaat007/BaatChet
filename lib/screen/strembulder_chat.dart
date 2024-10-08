import 'package:baatchit/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StreamBuilderChat extends StatefulWidget {
  StreamBuilderChat({super.key});

  @override
  State<StreamBuilderChat> createState() => _StreamBuilderChatState();
}

class _StreamBuilderChatState extends State<StreamBuilderChat> {
  final messageController = TextEditingController();

  // final _database = FirebaseDatabase.instance;

  List<Map> allMsg = [];

  final event = FirebaseDatabase.instance.ref("Chats");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeChat();
  }

  initializeChat() {
    event.onChildAdded.listen((event) {
      final msg = event.snapshot.value as Map<Object?, Object?>;
      if (mounted) setState(() => allMsg.add(msg));
    });

    event.onChildChanged.listen((event) {
      final res = event.snapshot.value.toString();
      final id = event.snapshot.key.toString();
      print(res);
      print(id);
    });

    event.onChildRemoved.listen((event) {
      print(event.snapshot.key);
    });
  }

  void sendMessage() {
    final newMsg = {
      "msg": "Let's have a talk",
      "sender": "Sachin",
      "time": DateTime.now().toIso8601String()
    };
    event.push().set(newMsg);
  }

  // List<String> msg = [];
  @override
  Widget build(BuildContext context) {
    // final db = FirebaseFirestore.instance.collection("user").doc("ankit");

    // adddata(ChatModel model) {
    //   try {
    //     db.set(model.tomsg());
    //   } catch (e) {
    //     rethrow;
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Group chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // TextButton(onPressed: sendMessage, child: Text("Send Now")),

            // ...List.generate(allMsg.length, (i) {
            //   final message = allMsg[i];
            //   return Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Text(message['msg']),
            //   );
            // })
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No data found'));
                    } else {
                      final chatDocs = snapshot.data!.docs;
                      return ListView.builder(
                        reverse: true,
                        itemCount: chatDocs.length,
                        itemBuilder: (ctx, index) {
                          return Row(
                            mainAxisAlignment:
                                chatDocs[index]['sender'] == "ankit"
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              chatDocs[index]['sender'] == "ankit"
                                  ? Chip(
                                      label: Text(chatDocs[index]['message']),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Chip(
                                        label: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(chatDocs[index]['message']),
                                            Text(
                                              chatDocs[index]['sender'],
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
                      );
                    }
                  }),
            )
          ],
        ),
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
                    onPressed: _sendMessage,
                    //  () {
                    //   msg.add(messageController.text);
                    //   // adddata(ChatModel(msg: msg));
                    // },
                    icon: const Icon(Icons.keyboard_double_arrow_right_sharp)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendMessage() async {
    final message = messageController.text;
    if (message.trim().isEmpty) return;

    // Send message to Firestore
    await FirebaseFirestore.instance
        .collection('chats')
        .add(ChatModel(message: message).tomsg());

    messageController.clear();
  }
}
