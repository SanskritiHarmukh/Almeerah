import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
      colorScheme: ColorScheme.light(
    background: Color(0xfff7f7f7),
        primary: Color(0xff091019),

),
);
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      background: Color(0xff091019),
    primary: Color(0xfff7f7f7),

  ),
);