import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class CbOutlinedButtonTheme {
  CbOutlinedButtonTheme._();


/* -- App ElevatedButton Theme -- */

// -- Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: cbSecondaryColor,
      side: BorderSide(color: cbSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: cbButtonHeight),
    ),
  );

// -- Dark Theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: cbWhiteColor,
      side: BorderSide(color: cbWhiteColor),
      padding: EdgeInsets.symmetric(vertical: cbButtonHeight),
    ),
  );
}