import 'package:flutter/material.dart';

appTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  String fontFamily = 'Arial',
  double height = 1.1,
  TextOverflow? overflow,
  FontStyle? fontStyle,
}) =>
    TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
        overflow: overflow);

