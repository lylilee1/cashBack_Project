

import 'package:flutter/material.dart';


class SizeConfig {
  //SizeConfig._();

  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }



// -- App default Sizing
  static const cbDefaultSize                = 30.0;
  static const cbSplashContainerSize        = 30.0;
  static const cbButtonHeight               = 15.0;
  static const cbFormHeight                 = 30.0;

// -- App default Sizing
  static const cbDashboardPadding           = 20.0;
  static const cbDashboardCardPadding       = 10.0;

// =========================== //

/* Start of BorderRadius */

  static const double kBorderRadius20 = 20.0;
  static const double kBorderRadius10 = 10.0;
  static const double kBorderRadius5 = 5.0;

/* End of BorderRadius */

// =========================== //

/* Start of Padding */

  static const double kPadding32 = 32.0;
  static const double kPadding24 = 24.0;
  static const double kPadding20 = 20.0;
  static const double kPadding16 = 16.0;
  static const double kPadding8 = 8.0;
  static const double kPadding4 = 4.0;

/* End of Padding */
}