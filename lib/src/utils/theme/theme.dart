import 'package:cashback/src/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'elevated_button_theme.dart';
import 'outlined_button_theme.dart';

class CbTheme{
/*prevent user for accessing the page theme*/
  CbTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,/*
    colorSchemeSeed: Color(0xFF3FA036),
    scaffoldBackgroundColor: cbCardBgColor,*/
    brightness: Brightness.light,
    textTheme: CbTextTheme.lightTextTheme,
    outlinedButtonTheme: CbOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: CbElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: CbTextTheme.darkTextTheme,
    outlinedButtonTheme: CbOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: CbElevatedButtonTheme.darkElevatedButtonTheme,
  );
}