import 'package:flutter/material.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';

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
      style: TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.backgroundColor,
                width: 2.0)),
        focusedBorder: const OutlineInputBorder(
            borderSide:
            BorderSide(color: AppColors.backgroundColor, width: 2.0)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.backgroundColor,
                width: 2.0)),
        labelText: '$label',
        hintText:hint != null? "$hint" : " ",
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}