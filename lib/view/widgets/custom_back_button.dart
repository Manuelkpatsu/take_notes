import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final GestureTapCallback onTap;

  CustomBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 0,
                top: 10,
                bottom: 10,
              ),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
              ),
            ),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

