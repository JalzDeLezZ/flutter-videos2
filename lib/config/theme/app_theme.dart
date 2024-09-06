import 'package:flutter/material.dart';

class AppTheme {
  AppTheme({this.isDarkmode = true});

  final bool isDarkmode;

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
      );

  AppTheme copyWith({bool? isDarkmode}) {
    return AppTheme(isDarkmode: isDarkmode ?? this.isDarkmode);
  }
}
