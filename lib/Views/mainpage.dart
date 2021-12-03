import 'package:flutter/material.dart';
import 'package:tema8/Views/Widgets/mydropdownbutton.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Translator'),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            MyDropDownButton(),
            Text('Hello world')
          ],
        )
      ),
    );
  }
}