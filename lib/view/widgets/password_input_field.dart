import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FormFieldValidator<String>? validator;
  final TextCapitalization textCapitalization;
  final bool? obscureText;
  final VoidCallback? toggle;

  PasswordInputField({
    required this.controller,
    this.inputType,
    this.inputAction,
    this.validator,
    this.obscureText,
    this.toggle,
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
        suffixIcon: IconButton(
          icon: obscureText! ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          onPressed: toggle,
        )
      ),
      keyboardType: inputType,
      textInputAction: inputAction,
      obscureText: obscureText!,
      validator: validator,
      textCapitalization: textCapitalization,
    );
  }
}
