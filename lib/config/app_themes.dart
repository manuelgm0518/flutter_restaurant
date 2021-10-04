import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:derived_colors/derived_colors.dart';
export 'package:derived_colors/derived_colors.dart';

// Color Palette
const Color kPrimaryColor = Color(0xFF2196F3); // Blue
const Color kSecondaryColor = Color(0xFF0D47A1); // Blue shade 900

const Color kInfoColor = Color(0xFF00BCD4); // Info
const Color kSuccessColor = Color(0xFF4CAF50); // Green
const Color kErrorColor = Color(0xFFF44336); // Red
const Color kWarningColor = Color(0xFFFFC107); // Amber

const Color kLightColor = Color(0xFFECEFF1); // Blue Grey 50
const Color kDarkColor = Color(0xFF78909C); //Blue  Grey 400

class AppThemes {
  static ThemeData main = new ThemeData(
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      primaryVariant: kPrimaryColor.variants.dark,
      onPrimary: Colors.white,
      secondary: kSecondaryColor,
      secondaryVariant: kSecondaryColor.variants.dark,
      onSecondary: Colors.white,
      error: kErrorColor,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      background: kLightColor,
      onBackground: Colors.black,
    ),
    hintColor: kSecondaryColor.variants.dark,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 122, fontWeight: FontWeight.bold, height: 1.1),
      headline2: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, height: 1.1),
      headline3: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, height: 1.1),
      headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, height: 1.1),
      headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.1),
      headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.1),
      subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.1),
      subtitle2: TextStyle(fontSize: 16),
      bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 14),
      caption: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
      button: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      overline: TextStyle(fontSize: 10),
    ),
    scaffoldBackgroundColor: kLightColor,
    cardTheme: CardTheme(shape: RoundedRectangleBorder(borderRadius: kRoundedBorder), elevation: 0, margin: EdgeInsets.zero),
    dividerColor: kLightColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kPrimaryColor.variants.light,
      border: UnderlineInputBorder(borderRadius: kRoundedBorder, borderSide: BorderSide.none),
      focusedBorder: UnderlineInputBorder(borderRadius: kRoundedBorder, borderSide: BorderSide.none),
      errorBorder: UnderlineInputBorder(borderRadius: kRoundedBorder, borderSide: BorderSide.none),
      focusedErrorBorder: UnderlineInputBorder(borderRadius: kRoundedBorder, borderSide: BorderSide.none),
      isDense: true,
    ),
  );
}
