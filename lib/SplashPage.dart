import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tic_tac_toe/StartPage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      image: Image(
        image: AssetImage('assets/logo.png'),
      ),
      photoSize: 100,
      seconds: 5,
      navigateAfterSeconds: StartPage(),
      backgroundColor: Colors.transparent,
      styleTextUnderTheLoader: TextStyle(),
      loaderColor: Color(0xFF00BF72),
    );
  }
}