import 'package:baatchit/screen/chat_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BaatChet"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: List.generate(
          5,
          (index) => ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChatScreen()));
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
