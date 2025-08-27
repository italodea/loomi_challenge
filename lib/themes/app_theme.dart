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
  static const darker = Color(0xFF30303B);
  static const textColor = Colors.white;
  static const textDarkColor = Color(0xFF86878B);

  static const listProfileColors = [
    Color(0xFFBC4CF1),
    Color(0xFF351F43),
    Color(0xFFFFEB3B),
    Color(0xFF2196F3),
    Color(0xFFFF9800),
    Color(0xFFE91E63),
    Color(0xFF795548),
    Color(0xFF4CAF50),
  ];

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: backgroundColor, elevation: 0, toolbarHeight: 0),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      textTheme: textThemePrimary,
      inputDecorationTheme: inputTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      iconButtonTheme: iconButtonTheme,
      textButtonTheme: textButtonTheme,
      snackBarTheme: snackBarTheme,
    );
  }

  static TextTheme get textThemePrimary {
    return GoogleFonts.montserratTextTheme(textTheme);
  }

  static TextTheme get textThemeSecondary {
    return GoogleFonts.epilogueTextTheme(textTheme);
  }

  static TextTheme get textTheme {
    return const TextTheme(
      bodyLarge: TextStyle(
        color: AppTheme.textColor,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      bodyMedium: TextStyle(
        color: AppTheme.textColor,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      bodySmall: TextStyle(
        color: AppTheme.textColor,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
      displayLarge: TextStyle(
        color: AppTheme.textColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: AppTheme.textColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: AppTheme.textColor,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        color: AppTheme.textColor,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: AppTheme.textColor,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: AppTheme.textColor,
        fontSize: 24,
        fontWeight: FontWeight.w300,
      ),
      titleLarge: TextStyle(
        color: AppTheme.textColor,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: AppTheme.textColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: AppTheme.textColor,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: TextStyle(
        color: AppTheme.textColor,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      labelMedium: TextStyle(
        color: AppTheme.textColor,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      labelSmall: TextStyle(
        color: AppTheme.textColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static InputDecorationTheme get inputTheme {
    return InputDecorationTheme(
      labelStyle: textThemeSecondary.labelMedium,
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
      suffixIconColor: AppTheme.textDarkColor,
      hintStyle: textThemeSecondary.bodyMedium!.copyWith(
        color: AppTheme.textDarkColor,
      ),
      errorStyle: textThemeSecondary.bodySmall!.copyWith(
        color: AppTheme.errorColor,
      ),
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
        textStyle: textThemeSecondary.labelLarge,
      ),
    );
  }

  static IconButtonThemeData get iconButtonTheme {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  static TextButtonThemeData get textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.only(left: 5, right: 5, top: 2),
        foregroundColor: AppTheme.primaryColor,
        textStyle: textThemeSecondary.labelLarge,
      ),
    );
  }

  static SnackBarThemeData get snackBarTheme {
    return SnackBarThemeData(
      backgroundColor: AppTheme.primaryDarkColor,
      contentTextStyle: textThemeSecondary.bodyMedium,
      actionTextColor: AppTheme.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: AppTheme.primaryColor)),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
    );
  }
}
