import 'package:baatchit/components/coman_textField.dart';
import 'package:flutter/material.dart';

class GmailSignup extends StatelessWidget {
  GmailSignup({super.key});
  final namecontroller = TextEditingController();
  final gmailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("gmial sign up"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ComanTextfield(
            controller: namecontroller,
            hintText: "UserName",
            prefexIcon: Icons.person,
          ),
          const SizedBox(
            height: 10,
          ),
          ComanTextfield(
            controller: gmailcontroller,
            hintText: "Gmail",
            prefexIcon: Icons.mail,
          ),
          const SizedBox(
            height: 10,
          ),
          ComanTextfield(
            controller: passwordcontroller,
            hintText: "Password",
            prefexIcon: Icons.key,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("SignUp"))
        ],
      ),
    );
  }
}
