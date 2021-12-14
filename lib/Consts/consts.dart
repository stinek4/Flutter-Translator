import 'package:flutter/material.dart';

enum enumFromOrTo{
  FROM,
  TO,
}

//Key for shared prefs
String historyKey = "history";
String favoritesKey = "favorites";

final translateAppTheme = ThemeData.light().copyWith(
    highlightColor: Colors.blue[500],
    primaryColor: Colors.blue[500],
  scaffoldBackgroundColor: Colors.grey[300],
);