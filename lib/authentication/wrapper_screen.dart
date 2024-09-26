import 'package:baatchit/authentication/gmail_and_password/gmail_login.dart';
import 'package:baatchit/authentication/gmail_and_password/verification_email.dart';
import 'package:baatchit/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.data == null) {
            return GmailLogin();
          } else {
            if (snapshot.data!.emailVerified == true) {
              return HomeScreen();
            }
            return VerificationEmail();
          }
        },
      ),
    );
  }
}
