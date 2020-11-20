import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts{

  static TextStyle getMainFont({double fontSize, Color color, FontStyle fontStyle,FontWeight fontWeight,double letterSpacing, decoration}){
    return GoogleFonts.nunitoSans(
      fontSize: fontSize,
      color: color,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }
}