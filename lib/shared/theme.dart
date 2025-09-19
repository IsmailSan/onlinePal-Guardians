import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // <-- tambahkan ini
import 'package:google_fonts/google_fonts.dart';

Color blackColor = const Color(0xFF000000);
Color grayColor = const Color(0xFF737373);
Color softGrayColor = const Color(0xFFe8e7df);
Color whiteColor = const Color(0xFFFFFFFF);
Color softBlueColor = const Color(0xFF94A7F5);
Color lightBlueColor = const Color(0xFFD6DDFF);
Color purpleColor = const Color(0xFF4F4CFF);
Color strongPurpleColor = const Color(0xFF0E09FE);
Color bottomNavGray = const Color(0xFF7F7E8A);
Color pastelPurple = const Color(0xFF94A7F5);
Color greenColor = const Color(0xFF33cb5b);
Color redColor = const Color(0xFFf84333);

// Conditional fallback to avoid crash in release mode
TextStyle blackTextStyle = kReleaseMode
    ? TextStyle(color: blackColor)
    : GoogleFonts.roboto(color: blackColor);

TextStyle grayTextStyle = kReleaseMode
    ? TextStyle(color: grayColor)
    : GoogleFonts.roboto(color: grayColor);

TextStyle whiteTextStyle = kReleaseMode
    ? TextStyle(color: whiteColor)
    : GoogleFonts.roboto(color: whiteColor);

TextStyle purpleTextStyle = kReleaseMode
    ? TextStyle(color: purpleColor)
    : GoogleFonts.roboto(color: purpleColor);

TextStyle redTextStyle = kReleaseMode
    ? TextStyle(color: redColor)
    : GoogleFonts.roboto(color: redColor);

FontWeight extraLight = FontWeight.w100;
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

FontStyle normal = FontStyle.normal;
FontStyle italic = FontStyle.italic;
