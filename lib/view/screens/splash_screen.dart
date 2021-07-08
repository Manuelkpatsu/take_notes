import 'dart:async';

import 'package:flutter/material.dart';
import 'package:takenotes/utils/note_colors.dart';
import 'package:takenotes/view/widgets/background_image.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

//  @override
//  void initState() {
//    Timer(Duration(seconds: 3), () async {
//      if (true) {
//        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
//      } else {
//        Navigator.of(context)
//            .pushNamedAndRemoveUntil('/login', (route) => false);
//      }
//    });
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackgroundImage(image: 'assets/images/splash.jpeg'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Take Notes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        NoteColors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Enjoy it while it lasts.',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
