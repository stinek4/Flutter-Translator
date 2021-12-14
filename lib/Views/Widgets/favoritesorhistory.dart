import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tema8/Models/appdata.dart';

class FavoritesOrHistory extends StatelessWidget{
  AppData provider;
  FavoritesOrHistory(this.provider);

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Favorites"),
        Switch(value: provider.shouldShowHistory,
            onChanged: (newValue) =>{
          provider.showHistory(newValue)
            },
        activeColor: Colors.amberAccent,
        inactiveTrackColor: Colors.green[300],
        inactiveThumbColor: Colors.green,
        ),
        Text("History"),
      ],
    );
  }
}