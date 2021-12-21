import 'package:flutter/material.dart';

class NoteTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextStyle? style;

  const NoteTextField({
    Key? key,
    required this.controller,
    this.validator,
    this.hintText,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      style: style,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Colors.black12,
        hintText: hintText,
        contentPadding: EdgeInsets.all(10),
      ),
      validator: validator,
    );
  }
}
