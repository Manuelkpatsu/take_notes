import 'package:flutter/material.dart';

class MemojiColors {
  const MemojiColors._();

  static const black = Color(0xFF262626);
  static const amber = Color(0xFFf9d6a1);
  static const white = Color(0xFFcccccc);
  static const yellow = Color(0xFFffdf80);
  static const green = Color(0xFF98e79c);
  static const red = Color(0xFFf5bcca);
  static const blue = Color(0xFF9fd7f9);
  static const purple = Color(0xFFcbbaf7);

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
