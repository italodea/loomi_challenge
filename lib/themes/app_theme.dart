import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const backgroundColor = Color(0xFF131418);
  static const backgroundInputColor = Color(0xFF23252C);
  static const primaryColor = Color(0xFFBC4CF1);
  static const primaryDarkColor = Color(0xFF351F43);
  static const secondaryColor = Color(0xFFBBBBBB);
  static const secondaryDarkColor = Color(0xFF616264);
  static const borderColor = Color(0xFF6C6D7A);
  static const activeBorderColor = Color(0xFFAA73F0);
  static const errorColor = Color(0xFFFF4D4D);

  static const textColor = Colors.white;
  static const textColorDark = Colors.white70;

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: backgroundColor, elevation: 0),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      textTheme: textTheme,
      inputDecorationTheme: inputTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      iconButtonTheme: iconButtonTheme,
      textButtonTheme: textButtonTheme,
    );
  }

  static TextTheme get textTheme {
    return GoogleFonts.montserratTextTheme(
      const TextTheme(
        bodyLarge: TextStyle(color: AppTheme.textColor, fontSize: 16),
        bodyMedium: TextStyle(color: AppTheme.textColorDark, fontSize: 14),
        bodySmall: TextStyle(color: AppTheme.textColorDark, fontSize: 12),
        displayLarge: TextStyle(
          color: AppTheme.textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: AppTheme.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: TextStyle(
          color: AppTheme.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          color: AppTheme.textColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppTheme.textColor,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: AppTheme.textColor,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: AppTheme.textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppTheme.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: AppTheme.textColor,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: AppTheme.textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          color: AppTheme.textColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: TextStyle(
          color: AppTheme.textColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static InputDecorationTheme get inputTheme {
    return InputDecorationTheme(
      labelStyle: textTheme.labelMedium,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderColor, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppTheme.errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppTheme.errorColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderColor, width: 1),
      ),
      filled: true,
      fillColor: backgroundInputColor,
      suffixIconColor: AppTheme.textColorDark,
      hintStyle: textTheme.bodyMedium!.copyWith(color: AppTheme.textColorDark),
      errorStyle: textTheme.bodySmall!.copyWith(color: AppTheme.errorColor),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    );
  }

  static OutlinedButtonThemeData get outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
        side: BorderSide(color: AppTheme.primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppTheme.primaryDarkColor,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        minimumSize: Size(250, 48),
      ),
    );
  }

  static IconButtonThemeData get iconButtonTheme {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  static TextButtonThemeData get textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 5),
        foregroundColor: AppTheme.primaryColor,
        textStyle: textTheme.labelLarge,
      ),
    );
  }
}
