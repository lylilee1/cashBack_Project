import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class CbOutlinedButtonTheme {
  CbOutlinedButtonTheme._();


/* -- App ElevatedButton Theme -- */

// -- Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: cbSecondaryColor,
      side: BorderSide(color: cbSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: CbSizings.cbButtonHeight),
    ),
  );

// -- Dark Theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: cbWhiteColor,
      side: BorderSide(color: cbWhiteColor),
      padding: EdgeInsets.symmetric(vertical: CbSizings.cbButtonHeight),
    ),
  );
}