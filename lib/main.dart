import 'package:flutter/material.dart';
import 'package:tema8/Views/mainpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Translate',
      home: MainPage(),
    );
  }
}
