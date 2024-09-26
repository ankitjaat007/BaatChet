import 'package:baatchit/authentication/gmail_and_password/gmail_login.dart';
import 'package:baatchit/components/coman_textField.dart';
import 'package:baatchit/controller/auth/gmail_password_controller.dart';
import 'package:baatchit/controller/circularProgressIndicator_controller.dart';
import 'package:baatchit/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GmailSignup extends StatelessWidget {
  GmailSignup({super.key});
  final namecontroller = TextEditingController();
  final gmailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loder =
        Provider.of<CircularProgressIndicatorController>(context).loding;
    return Scaffold(
      floatingActionButton: CircleAvatar(
          radius: 40,
          child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => GmailLogin()));
              },
              child: const Text("Login"))),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          ElevatedButton(
              onPressed: loder
                  ? null
                  : () {
                      GmailPasswordController().signup(
                          Usermodel(
                              email: gmailcontroller.text,
                              name: namecontroller.text),
                          passwordcontroller.text,
                          context);
                    },
              child: loder ? CircularProgressIndicator() : Text("SignUp"))
        ],
      ),
    );
  }
}
