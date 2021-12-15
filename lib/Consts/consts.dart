import 'package:flutter/material.dart';

//Enum class to safeguard which languages you translate from and to.
enum enumFromOrTo{
  FROM,
  TO,
}

//Key for shared prefs
String historyKey = "history";
String favoritesKey = "favorites";

//Theme set in main.dart for entire app
final translateAppTheme = ThemeData.light().copyWith(
    highlightColor: Colors.blue[500],
    primaryColor: Colors.blue[500],
  scaffoldBackgroundColor: Colors.grey[300],
);