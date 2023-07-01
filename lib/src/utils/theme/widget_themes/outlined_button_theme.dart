import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class CbOutlinedButtonTheme {
  CbOutlinedButtonTheme._();


/* -- App ElevatedButton Theme -- */

// -- Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: cbSecondaryColor,
      side: const BorderSide(color: cbSecondaryColor),
      padding: const EdgeInsets.symmetric(vertical: CbSizings.cbButtonHeight),
    ),
  );

// -- Dark Theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: CbColors.cbWhiteColor,
      side: const BorderSide(color: CbColors.cbWhiteColor),
      padding: const EdgeInsets.symmetric(vertical: CbSizings.cbButtonHeight),
    ),
  );
}