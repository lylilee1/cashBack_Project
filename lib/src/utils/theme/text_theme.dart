import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_with_animation/src/constants/colors.dart';

class CbTextTheme{
  static TextTheme lightTextTheme = TextTheme(
      headline1: GoogleFonts.montserrat( fontSize: 28.0, fontWeight: FontWeight.bold, color: cbDarkColor,),
      headline2: GoogleFonts.montserrat( fontSize: 24.0, fontWeight: FontWeight.w700, color: cbDarkColor,),
      headline3: GoogleFonts.poppins( fontSize: 24.0, fontWeight: FontWeight.w700, color: cbDarkColor,),
      headline4: GoogleFonts.poppins( fontSize: 16.0, fontWeight: FontWeight.w600, color: cbDarkColor,),
      headline6: GoogleFonts.poppins( fontSize: 14.0, fontWeight: FontWeight.w600, color: cbDarkColor,),
      bodyText1: GoogleFonts.poppins( fontSize: 14.0, fontWeight: FontWeight.normal, color: cbDarkColor,),
  );


  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.montserrat( fontSize: 28.0, fontWeight: FontWeight.bold, color: cbWhiteColor,),
    headline2: GoogleFonts.montserrat( fontSize: 24.0, fontWeight: FontWeight.w700, color: cbWhiteColor,),
    headline3: GoogleFonts.poppins( fontSize: 24.0, fontWeight: FontWeight.w700, color: cbWhiteColor,),
    headline4: GoogleFonts.poppins( fontSize: 16.0, fontWeight: FontWeight.w600, color: cbWhiteColor,),
    headline6: GoogleFonts.poppins( fontSize: 14.0, fontWeight: FontWeight.w600, color: cbWhiteColor,),
    bodyText1: GoogleFonts.poppins( fontSize: 14.0, fontWeight: FontWeight.normal, color: cbWhiteColor,),
  );
}