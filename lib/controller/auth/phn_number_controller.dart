import 'package:baatchit/authentication/otp_verify.dart';
import 'package:baatchit/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhnNumberController {
  final _auth = FirebaseAuth.instance;
  String verificationId = "";
  Future<void> verifyPhoneNumber(String number, BuildContext ctx) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91$number",
          verificationCompleted: (credentials) {},
          verificationFailed: (FirebaseAuthException exception) {
            print(exception);
            print("-------------------------");
          },
          codeSent: (verificationid, code) {
            verificationId = verificationid;
            Navigator.push(
                ctx, MaterialPageRoute(builder: (context) => OtpVerify()));
            print(verificationId);
            print("*************");
          },
          codeAutoRetrievalTimeout: (error) {});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> verifyOtp(String otp, BuildContext ctx) async {
    try {
      // final response =
      await _auth
          .signInWithCredential(
              AuthCredential(providerId: verificationId, signInMethod: otp))
          .then(
            (value) => Navigator.push(
                ctx, MaterialPageRoute(builder: (context) => HomeScreen())),
          );
      // final uid = response.user!.uid;
    } catch (e) {
      print(e.toString());
      print("*****++++++******");
    }
  }
}

// ****************************************
// class AuthController {
//   // FIREBASE AUTH
//   final _auth = FirebaseAuth.instance;
//   final _db = FirebaseFirestore.instance;

//   String verificationId = "";

//   // ProfielModel _user;

//   Future<void> verifyPhoneNumber(String phone) async {
//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: "+91$phone",
//           verificationCompleted: (credentials) {},
//           verificationFailed: _onVerificationFailed,
//           codeSent: (verificationId, code) {
//             // TODO: HANDLE THE CODE WHEN THE OTP IS SENT SECCESSFULLY
//           },
//           codeAutoRetrievalTimeout: (ERROR) {
//             // TODO: WHEN TIME RETRIEVAL IS TIMEDOUT`
//           });
//     } catch (e) {
//       // TODO: HANDLE AUTH FUNCTION ERRORS HERE.
//     }
//   }

//   _onVerificationFailed(FirebaseAuthException error) {}

//   Future<void> verifyOtp(String otp) async {
//     try {
//       /**
//        * the method will send an otp on
//        * [usermodel.phoneNumber] which will be required to
//        * authenticate the user using
//        * [verificationId and OTP] functionality.
//        */
//       final response = await _auth.signInWithCredential(
//           AuthCredential(providerId: this.verificationId, signInMethod: otp));
//       final uid = response.user!.uid;
//       Map<String, dynamic> profile = getProfile();
//       profile.addAll({"uid": uid});
//       // METHOD TO UPDATE USER PROFILE ON FIRESTORE.
//       saveProfiletoFireStore(profile, uid);
//     } catch (e) {}
//   }

//   Map<String, dynamic> getProfile() {
//     // profile.toUserData();
//     return {};
//   }

//   Future<void> updateProfile() async {
//     /**
//      * final data  = get.controlerName();
//      */
//     try {
//       await _db.collection("users").doc("data.uid");
//     } catch (e) {}
//   }

//   Future<void> updateAddress() async {
//     try {
//       await _db.collection("addresses").doc(_auth.currentUser!.uid);
//     } catch (e) {}
//   }

//   saveProfiletoFireStore(Map<String, dynamic> user, String uid) async {
//     try {
//       await _db.collection("users").add({});

//       /**
//        * docId
//        * userId
//        */
//     } catch (e) {}
//   }
// }
