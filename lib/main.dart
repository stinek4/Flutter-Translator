import 'package:flutter/material.dart';
import 'package:tema8/Views/mainpage.dart';
import 'package:tema8/Consts/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Translate',
      theme: translateAppTheme,
      home: MainPage(),
    );
  }
}
