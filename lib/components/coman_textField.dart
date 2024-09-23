import 'package:flutter/material.dart';

class ComanTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData prefexIcon;
  const ComanTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.prefexIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        // keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIconColor: Colors.black,
          contentPadding: const EdgeInsets.all(0),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(prefexIcon),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
        ));
  }
}
