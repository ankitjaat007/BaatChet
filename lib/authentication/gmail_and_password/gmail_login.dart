import 'package:baatchit/authentication/gmail_and_password/gmail_signup.dart';
import 'package:baatchit/components/coman_textField.dart';
import 'package:baatchit/controller/auth/gmail_password_controller.dart';
import 'package:baatchit/controller/circularProgressIndicator_controller.dart';
import 'package:baatchit/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GmailLogin extends StatelessWidget {
  GmailLogin({super.key});
  final _gmailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loder =
        Provider.of<CircularProgressIndicatorController>(context).loding;
    return Scaffold(
      floatingActionButton: CircleAvatar(
          radius: 40,
          child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GmailSignup()));
              },
              child: const Text("signUp"))),
      appBar: AppBar(
        title: const Text("gmial login"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ComanTextfield(
            controller: _gmailcontroller,
            hintText: "Gmail",
            prefexIcon: Icons.mail,
          ),
          const SizedBox(
            height: 10,
          ),
          ComanTextfield(
            controller: _passwordcontroller,
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
                      GmailPasswordController().login(
                          Usermodel(email: _gmailcontroller.text),
                          _passwordcontroller.text,
                          context);
                    },
              child: loder ? CircularProgressIndicator() : Text("Login"))
        ],
      ),
    );
  }
}
