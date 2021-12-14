import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tema8/Consts/consts.dart';
import 'package:tema8/Models/appdata.dart';
import 'package:tema8/Views/Widgets/mydropdownbutton.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyDropDownButton(),
                IconButton(icon: const Icon(Icons.arrow_drop_down), onPressed: () {
                  Provider.of<AppData>(context, listen: false).switchLanguages();
                }),
                MyDropDownButton(),
              ],
            ),
            Divider(),
            //InputField(),
            Divider(),
        ]
        )
      )
    );
  }
}
        /*
        appBar: AppBar(
        title: Text('Google Translator'),
        ),*/
/*      body: SingleChildScrollView(
        child: Row(
          children: [
            MyDropDownButton(),
            Text('Hello world')
          ],
        )
      ),*/