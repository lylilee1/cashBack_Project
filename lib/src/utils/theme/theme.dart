import 'package:cashback/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:cashback/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:cashback/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:cashback/src/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class CbAppTheme {
/*prevent user for accessing the page theme*/
  CbAppTheme._();

  static ThemeData lightTheme = ThemeData(
    //useMaterial3: true,
    /*
    colorSchemeSeed: Color(0xFF3FA036),
    scaffoldBackgroundColor: cbCardBgColor,*/
    brightness: Brightness.light,
    textTheme: CbTextTheme.lightTextTheme,
    outlinedButtonTheme: CbOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: CbElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: CbTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    //useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: CbTextTheme.darkTextTheme,
    outlinedButtonTheme: CbOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: CbElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: CbTextFormFieldTheme.darkInputDecorationTheme,
  );
}
