import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class CbElevatedButtonTheme {
  CbElevatedButtonTheme._();


/* -- App ElevatedButton Theme -- */

// -- Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: cbWhiteColor,
      backgroundColor: cbSecondaryColor,
      side: BorderSide(color: cbSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: cbButtonHeight),
    ),
  );

// -- Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: cbSecondaryColor,
      backgroundColor: cbWhiteColor,
      side: BorderSide(color: cbWhiteColor),
      padding: EdgeInsets.symmetric(vertical: cbButtonHeight),
    ),
  );
}