String startThemeStyle() => '''
import 'package:flutter/material.dart';

class AppTheme {

  ThemeData themeData(){
    return ThemeData(
      textTheme: _textTheme(),
    );
  }

  TextTheme _textTheme(){
    return TextTheme(
      title: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500
      ), 
    );
  }


}
  ''';