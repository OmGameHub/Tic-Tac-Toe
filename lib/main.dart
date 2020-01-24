import 'package:flutter/material.dart';

import 'SplashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tic Tac Toe",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: SplashPage(),
    );
  }
}