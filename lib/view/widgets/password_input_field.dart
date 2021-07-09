import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;

  PasswordInputField({
    @required this.hint,
    @required this.controller,
    this.inputType,
    this.inputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
        hintText: hint,
      ),
      keyboardType: inputType,
      textInputAction: inputAction,
      obscureText: true,
    );
  }
}
