import 'package:flutter/material.dart';

class NoteColors {
  const NoteColors._();

  static const black = Color(0xFF262626);
  static const amber = Color(0xFFf9d6a1);
  static const white = Color(0xFFe8e8e8);
  static const yellow = Color(0xFFffe9a6);
  static const green = Color(0xFFc3f1c5);
  static const red = Color(0xFFf7c9d4);
  static const blue = Color(0xFFcbe9fc);
  static const purple = Color(0xFFddd2fa);

  static const values = [
    black,
    amber,
    white,
    yellow,
    green,
    red,
    blue,
    purple,
  ];

  static Color getValue(int? color) {
    switch (color) {
      case 0:
        return black;
      case 1:
        return amber;
      case 2:
        return white;
      case 3:
        return yellow;
      case 4:
        return green;
      case 5:
        return red;
      case 6:
        return blue;
      case 7:
        return purple;
      default:
        return Colors.white;
    }
  }
}
