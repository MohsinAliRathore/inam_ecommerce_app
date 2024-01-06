import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 1, 64, 77),
                width: 2.0)),
        focusedBorder: const OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.white, width: 2.0)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 1, 64, 77),
                width: 2.0)),
        labelText: '$label',
        hintText:hint != null? "$hint" : " ",
        hintStyle: const TextStyle(
          color: Colors.white30,
        ),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}