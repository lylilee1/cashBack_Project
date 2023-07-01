import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class CbElevatedButtonTheme {
  CbElevatedButtonTheme._();


/* -- App ElevatedButton Theme -- */

// -- Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: CbColors.cbWhiteColor,
      backgroundColor: cbSecondaryColor,
      side: const BorderSide(color: cbSecondaryColor),
      padding: const EdgeInsets.symmetric(vertical: CbSizings.cbButtonHeight),
    ),
  );

// -- Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: cbSecondaryColor,
      backgroundColor: CbColors.cbWhiteColor,
      side: const BorderSide(color: CbColors.cbWhiteColor),
      padding: const EdgeInsets.symmetric(vertical: CbSizings.cbButtonHeight),
    ),
  );
}