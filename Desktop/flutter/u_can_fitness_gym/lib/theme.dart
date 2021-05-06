import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryLightColor,
    scaffoldBackgroundColor: kPrimaryLightColor,
    appBarTheme: AppBarTheme(
        centerTitle: false, elevation: 0, backgroundColor: kPrimaryDarkColor),
    iconTheme: IconThemeData(color: kContentColorDarkTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme, fontFamily: kFontFamily),
    colorScheme: ColorScheme.light().copyWith(
      primary: kPrimaryLightColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryDarkColor,
    scaffoldBackgroundColor: kPrimaryDarkColor,
    appBarTheme: AppBarTheme(
        centerTitle: false, elevation: 0, backgroundColor: kSecondaryColor),
    iconTheme: IconThemeData(color: kContentColorLightTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorLightTheme, fontFamily: kFontFamily),
    colorScheme: ColorScheme.dark().copyWith(
      primary: kPrimaryDarkColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
  );
}
