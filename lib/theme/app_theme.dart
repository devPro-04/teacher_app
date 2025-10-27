import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF005BFE);
  static const Color darkNavy = Color(0xFF04132C);
  static const Color lightNavy = Color(0xFF041A2F);
  static const Color accentYellow = Color(0xFFFDBF00);
  static const Color lightBlue = Color(0xFFCCDEFF);
  static const Color backgroundGray = Color(0xFFF2F3F4);
  static const Color borderGray = Color(0xFFE6E7EA);
  static const Color textGray = Color(0xFF818995);
  static const Color errorRed = Color(0xFFFF5A2E);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFFF9800);

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Manrope',
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: primaryBlue,
        secondary: accentYellow,
        error: errorRed,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: darkNavy,
        onError: Colors.white,
        onSurface: darkNavy,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: darkNavy),
        titleTextStyle: TextStyle(
          color: darkNavy,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Manrope',
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: 'Manrope',
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: const BorderSide(color: errorRed, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  static TextStyle get headingLarge => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: darkNavy,
        letterSpacing: -0.5,
        height: 1.2,
      );

  static TextStyle get headingMedium => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: darkNavy,
        letterSpacing: -0.44,
        height: 1.3,
      );

  static TextStyle get headingSmall => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: darkNavy,
        letterSpacing: -0.4,
        height: 1.4,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: darkNavy,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: darkNavy,
        height: 1.5,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textGray,
        height: 1.5,
      );

  static TextStyle get labelLarge => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: darkNavy,
        letterSpacing: -0.3,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: darkNavy,
        letterSpacing: -0.2,
      );

  static TextStyle get labelSmall => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: textGray,
        letterSpacing: -0.2,
      );

  static BoxShadow get shadowSmall => BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 8,
        offset: const Offset(0, 2),
      );

  static BoxShadow get shadowMedium => BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 12,
        offset: const Offset(0, 4),
      );

  static BoxShadow get shadowLarge => BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 16,
        offset: const Offset(0, 6),
      );

  static BoxDecoration get cardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMedium),
        border: Border.all(color: borderGray),
        boxShadow: [shadowSmall],
      );

  static BoxDecoration get prominentCardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMedium),
        boxShadow: [shadowMedium],
      );
}
