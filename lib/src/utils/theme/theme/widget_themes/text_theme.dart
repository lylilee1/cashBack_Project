import 'package:cashback/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CbTextTheme{
/*prevent user for accessing the page theme*/
  CbTextTheme._();

// -- Light Text Theme --
  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.montserrat(fontSize: 28.0, fontWeight: FontWeight.bold, color: CbColors.cbDarkColor,),
    headline2: GoogleFonts.montserrat(fontSize: 24.0, fontWeight: FontWeight.w700, color: CbColors.cbDarkColor,),
    headline3: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: CbColors.cbDarkColor,),
    headline4: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w600, color: CbColors.cbDarkColor,),
    headline5: GoogleFonts.poppins(fontSize: 14.0, fontWeight : FontWeight.normal, color: CbColors.cbDarkColor,),
    headline6: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.normal, color: CbColors.cbDarkColor,),
  );

  // -- Dark Text Theme --
  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.montserrat(fontSize: 28.0, fontWeight: FontWeight.bold, color: CbColors.cbWhiteColor,),
    headline2: GoogleFonts.montserrat(fontSize: 24.0, fontWeight: FontWeight.w700, color: CbColors.cbWhiteColor,),
    headline3: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: CbColors.cbWhiteColor,),
    headline4: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w600, color: CbColors.cbWhiteColor,),
    headline5: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.normal, color: CbColors.cbWhiteColor,),
    headline6: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.normal, color: CbColors.cbWhiteColor,),
  );
}