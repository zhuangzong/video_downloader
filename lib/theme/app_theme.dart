import 'package:flutter/material.dart';


final ThemeData whiteThemeData = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    surfaceTintColor: Colors.white,
  ),
);

final ThemeData blackThemeData = ThemeData.dark().copyWith(
  primaryColor: Color(0xff141414),
  scaffoldBackgroundColor: Color(0xff141414),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff141414),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    surfaceTintColor: Colors.black,
  ),
);
