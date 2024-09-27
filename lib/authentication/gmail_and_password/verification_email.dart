import 'dart:async';

import 'package:baatchit/authentication/wrapper_screen.dart';
import 'package:baatchit/controller/auth/gmail_password_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationEmail extends StatefulWidget {
  const VerificationEmail({super.key});

  @override
  State<VerificationEmail> createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  final _auth = GmailPasswordController();
  late Timer timer;
  @override
  void initState() {
    super.initState();
    _auth.currentUserEmailVerifiedLink();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      FirebaseAuth.instance.currentUser!.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WrapperScreen(),
            ));
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("We have a send to email for verification"),
              ElevatedButton(
                  onPressed: () {
                    // _auth.emailVerifiedLink();
                  },
                  child: Text("resend")),
              IconButton(
                  onPressed: () {
                    GmailPasswordController().signout(context, "");
                  },
                  icon: Icon(Icons.exit_to_app))
            ],
          ),
        ),
      ),
    );
  }
}
