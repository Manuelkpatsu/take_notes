import 'package:flutter/material.dart';

class Helper {
  /// Shows a snackbar
  static void showSnackbar(BuildContext context, String text) {
    final snackbar = SnackBar(
      content: Text(text, style: TextStyle(color: Colors.white)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
