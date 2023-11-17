import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:eden_user_app/core/size_config/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Default [ThemeData] for Example
class AppTheme {
  /// Default constructor for Example [ThemeData]
  AppTheme(this._brightness);

  final Brightness _brightness;

  /// Exposes theme data to MaterialApp
  ThemeData get themeData {
    return ThemeData(brightness: _brightness).copyWith(
      colorScheme: _colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: _colorScheme.background,
      dividerTheme: DividerThemeData(
        color: _colorScheme.secondary,
        thickness: .5,
      ),
      appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(
            color: _colorScheme.secondary,
          ),
          backgroundColor: _colorScheme.background,
          centerTitle: true,
          titleTextStyle: GoogleFonts.dmSans(
              height: 1,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _colorScheme.secondary,
              letterSpacing: -.2)),
      disabledColor: EdenColors.lightTextColor,
      textTheme: GoogleFonts.dmSansTextTheme(
        TextTheme(
          displayLarge: GoogleFonts.dmSans(
              height: 1,
              fontSize: 64.text,
              fontWeight: FontWeight.w300,
              letterSpacing: -0.5),
          displayMedium: GoogleFonts.dmSans(
              height: 1, fontSize: 50.text, fontWeight: FontWeight.w400),
          displaySmall: GoogleFonts.dmSans(
            fontSize: 36.text,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          headlineMedium: GoogleFonts.dmSans(
            fontSize: 24.text,
            fontWeight: FontWeight.w700,
            height: 1,
            letterSpacing: 0.14,
          ),
          headlineSmall: GoogleFonts.dmSans(
              height: 1,
              fontSize: 18.text,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15),
          titleLarge: GoogleFonts.dmSans(
              height: 1,
              fontSize: 18.text,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.15),
          titleMedium: GoogleFonts.dmSans(
              height: 1,
              fontSize: 18.text,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.10),
          titleSmall: GoogleFonts.dmSans(
              height: 1,
              fontSize: 16.text,
              fontWeight: FontWeight.w700,
              letterSpacing: -.2),
          bodyLarge: GoogleFonts.dmSans(
              height: 1,
              fontSize: 16.text,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.11),
          bodyMedium: GoogleFonts.dmSans(
              height: 1,
              fontSize: 14.text,
              fontWeight: FontWeight.w500,
              letterSpacing: -.2),
          labelLarge: GoogleFonts.dmSans(
              height: 1,
              fontSize: 14.text,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.40),
          bodySmall: GoogleFonts.dmSans(
              height: 1,
              fontSize: 12.text,
              fontWeight: FontWeight.w400,
              letterSpacing: -.2),
          labelSmall: GoogleFonts.dmSans(
              height: 1,
              fontSize: 10.text,
              fontWeight: FontWeight.w400,
              letterSpacing: -.2),
        ),
      ).apply(
        bodyColor: EdenColors.textColor,
        displayColor: EdenColors.textColor,
      ),
    );
  }

  ColorScheme get _colorScheme => ColorScheme.fromSeed(
      seedColor: EdenColors.primaryGreen,
      brightness: _brightness,
      onBackground: EdenColors.lightTextColor,
      error: EdenColors.errorColor,
      primary: EdenColors.primaryGreen,
      tertiary: EdenColors.whiteColor,
      secondary: EdenColors.textColor,
      primaryContainer: EdenColors.cardGrey,
      background: EdenColors.background);
}
