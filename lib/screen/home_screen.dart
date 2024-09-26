import 'package:baatchit/controller/auth/gmail_password_controller.dart';
import 'package:baatchit/controller/firebase_controller.dart';
import 'package:baatchit/screen/realtime_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initializeChat();
  }

  // final event = FirebaseDatabase.instance.ref("AnkitChats");
  initializeChat() {
    final chatController = Provider.of<ChatController>(context, listen: false);
    // event.onChildAdded.listen((data) {
    //   chatController.addMsg(data);
    // });
    chatController.fatchMsg();
    chatController.fatchUpdateData();
    chatController.fatchRemoveData();
  }

  final _auth = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(_auth.toString()),
          IconButton(
              onPressed: () {
                GmailPasswordController().signout(context, "");
              },
              icon: Icon(Icons.exit_to_app))
        ],
        title: const Text("BaatChet"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: List.generate(
          1,
          (index) => ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RealtimeChat()));
            },
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/icons/dp.jpg",
                )),
            title: const Text("My group"),
            subtitle: const Text("welcome to my baatchet app"),
          ),
        ),
      ),
    );
  }
}
