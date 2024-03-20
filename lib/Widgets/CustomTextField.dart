import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final String hint;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final bool? longText;

  CustomTextField({
    this.controller,
    this.title,
    required this.hint,
    this.isPassword,
    this.validator,
    this.longText,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorMessage;

  void _validate(String? value) {
    setState(() {
      _errorMessage = widget.validator?.call(value) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null && widget.title != '')
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.title!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        TextFormField(
          maxLines: widget.longText != null? 4 : 1,
          controller: widget.controller,
          obscureText: widget.isPassword == true ? true : false,
          decoration: InputDecoration(
            hintText: widget.hint,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: _errorMessage?.isEmpty == true ? null : _errorMessage,
          ),
          onChanged: _validate,
        ),
      ],
    );
  }
}