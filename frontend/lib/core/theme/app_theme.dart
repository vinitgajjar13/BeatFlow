import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- Modern Vibrant Colors ---
  static const Color primaryColor = Color(0xFF1DB954); // Vibrant Spotify-style Green
  static const Color secondaryColor = Color(0xFFFF7A00); // Vibrant Onboarding Orange
  static const Color accentBlue = Color(0xFF00C2FF); // Modern Cyan Accent
  
  // Dark Palette
  static const Color darkBackground = Colors.transparent; // Transparent for dynamic ambient bg
  static const Color darkSurface = Color(0xFF161616);
  static const Color darkCard = Color(0x33FFFFFF); // 20% White for glassy effect
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0x99FFFFFF);

  // Light Palette
  static const Color lightBackground = Colors.transparent; // Transparent for dynamic ambient bg
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0x33000000); // 20% Black for glassy effect
  static const Color lightTextPrimary = Color(0xFF121212);
  static const Color lightTextSecondary = Color(0x99121212);

  // Gradients for Vibrancy
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, Color(0xFF128C3E)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryColor, Color(0xFFFF4D00)],
  );

  // Glass Elements
  static const LinearGradient glassGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x33FFFFFF), Color(0x0AFFFFFF)],
  );

  static const LinearGradient glassGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x33000000), Color(0x0A000000)],
  );

  // Rounded Corners Standard
  static const double borderRadius = 24.0;
  static final Radius radius = Radius.circular(borderRadius);
  static final BorderRadius geometry = BorderRadius.circular(borderRadius);

  // shared configuration
  static const pageTransitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  // --- DARK THEME DEFINITION ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryColor,
      fontFamily: GoogleFonts.outfit().fontFamily,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: -1.5),
        headlineMedium: const TextStyle(fontWeight: FontWeight.w800),
        titleLarge: const TextStyle(fontWeight: FontWeight.bold),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: geometry,
          side: const BorderSide(color: Color(0x1AFFFFFF), width: 1), // Glassy subtle border
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white, size: 28),
      pageTransitionsTheme: pageTransitions,
      dividerColor: const Color(0x1AFFFFFF),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        onSecondary: Colors.white,
      ),
    );
  }

  // --- LIGHT THEME DEFINITION ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
      primaryColor: primaryColor,
      fontFamily: GoogleFonts.outfit().fontFamily,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: const TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w900, letterSpacing: -1.5),
        headlineMedium: const TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w800),
        titleLarge: const TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
        bodyLarge: const TextStyle(color: lightTextPrimary),
        bodyMedium: const TextStyle(color: lightTextSecondary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: lightTextPrimary),
        titleTextStyle: TextStyle(color: lightTextPrimary, fontSize: 20, fontWeight: FontWeight.w800),
      ),
      cardTheme: CardThemeData(
        color: lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: geometry,
          side: const BorderSide(color: Color(0x1A000000), width: 1), // Glassy subtle border
        ),
      ),
      iconTheme: const IconThemeData(color: lightTextPrimary, size: 28),
      pageTransitionsTheme: pageTransitions,
      dividerColor: const Color(0x1A000000),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: lightSurface,
        onSurface: lightTextPrimary,
        onSecondary: Colors.white,
      ),
    );
  }

  // --- Legacy Compatibility Aliases ---
  static const Color onboardingOrange = secondaryColor;
  static const Color pureWhite = Colors.white;
  static const Color pureBlack = Colors.black;
  static const Color surfaceColor = darkSurface;
  static const Color textSecondary = darkTextSecondary;
}
