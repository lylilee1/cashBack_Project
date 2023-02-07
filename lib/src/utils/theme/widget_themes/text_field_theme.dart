import 'package:cashback/src/constants/colors.dart';
import 'package:flutter/material.dart';

class CbTextFormFieldTheme {
  CbTextFormFieldTheme._();

/* -- Light theme Form field -- */
  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: CbColors.cbPrimaryColor2,
    floatingLabelStyle: TextStyle(
      color: CbColors.cbPrimaryColor2,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: CbColors.cbPrimaryColor2),
    ),
  );

/* -- Dark theme Form field -- */
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: CbColors.cbPrimaryColor,
    floatingLabelStyle: TextStyle(
      color: CbColors.cbPrimaryColor,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: CbColors.cbPrimaryColor),
    ),
  );
}
