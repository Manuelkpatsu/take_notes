import 'package:flutter/material.dart';

class ColorPallete extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onSelect;
  final Color color;

  const ColorPallete({
    Key? key,
    required this.isSelected,
    required this.color,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: new Container(
        margin: EdgeInsets.all(8),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black26),
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : Container(),
      ),
      onTap: onSelect,
    );
  }
}
