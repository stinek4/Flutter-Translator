import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tema8/Models/appdata.dart';
import 'package:tema8/Views/mainpage.dart';
import 'package:tema8/Consts/consts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //Listens to ChangeNotifier, reebuilds whenever notifylistener() is called
    return ChangeNotifierProvider(
        create: (context) => AppData(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: translateAppTheme,
      home: MainPage(),
    ),
    );
  }
}
