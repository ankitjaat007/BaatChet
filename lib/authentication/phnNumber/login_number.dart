import 'package:baatchit/controller/auth/phn_number_controller.dart';
import 'package:baatchit/controller/circularProgressIndicator_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginNumber extends StatelessWidget {
  LoginNumber({super.key});
  final number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CircularProgressIndicatorController>(context).loding;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login with phone number"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
              controller: number,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIconColor: Colors.black,
                contentPadding: const EdgeInsets.all(0),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.phone_android),
                hintText: 'Phone number',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
              )),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                PhnNumberController().verifyPhoneNumber(number.text, context);
              },
              child: provider ? CircularProgressIndicator() : Text("Send otp"))
        ],
      ),
    );
  }
}
