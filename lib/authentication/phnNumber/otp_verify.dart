import 'package:baatchit/controller/auth/phn_number_controller.dart';
import 'package:baatchit/controller/circularProgressIndicator_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpVerify extends StatelessWidget {
  OtpVerify({super.key});
  final otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CircularProgressIndicatorController>(context).loding;
    return Scaffold(
      appBar: AppBar(
        title: Text("otp verify"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
              controller: otp,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIconColor: Colors.black,
                contentPadding: const EdgeInsets.all(0),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.phone_android),
                hintText: 'OTP',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
              )),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                PhnNumberController().verifyOtp(otp.text, context);
              },
              child: provider ? CircularProgressIndicator() : Text("Submit"))
        ],
      ),
    );
  }
}
