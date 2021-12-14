import 'package:flutter/material.dart';

enum NoteColor {
  black,
  amber,
  white,
  yellow,
  green,
  red,
  blue,
  purple,
}

extension NoteColorExtension on NoteColor {
  Color get colorValue {
    switch (this) {
      case NoteColor.black:
        return Color(0xFF262626);
      case NoteColor.amber:
        return Color(0xFFf9d6a1);
      case NoteColor.white:
        return Color(0xFFe8e8e8);
      case NoteColor.yellow:
        return Color(0xFFffe9a6);
      case NoteColor.green:
        return Color(0xFFc3f1c5);
      case NoteColor.red:
        return Color(0xFFf7c9d4);
      case NoteColor.blue:
        return Color(0xFFcbe9fc);
      case NoteColor.purple:
        return Color(0xFFddd2fa);
      default:
        return Colors.white;
    }
  }
}
