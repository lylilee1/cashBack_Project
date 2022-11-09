import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_with_animation/src/constants/colors.dart';
import 'package:splash_screen_with_animation/src/utils/theme/elevated_button_theme.dart';
import 'package:splash_screen_with_animation/src/utils/theme/outlined_button_theme.dart';
import 'package:splash_screen_with_animation/src/utils/theme/text_theme.dart';

class CbTheme{

  CbTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Color(0xFF3FA036),
    scaffoldBackgroundColor: cbCardBgColor,
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