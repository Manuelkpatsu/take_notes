import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;
  final TextCapitalization textCapitalization;

  PasswordInputField({
    @required this.controller,
    this.inputType,
    this.inputAction,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
      ),
      keyboardType: inputType,
      textInputAction: inputAction,
      obscureText: true,
      validator: validator,
      textCapitalization: textCapitalization,
    );
  }
}
