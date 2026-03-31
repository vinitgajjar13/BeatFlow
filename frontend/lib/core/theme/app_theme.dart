import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- Futuristic Premium Colors ---
  static const Color primaryColor =
      Color(0xFF00F2FF); // Vibrant Cyan from image
  static const Color secondaryColor =
      Color(0xFFFF00BF); // Vibrant Magenta from image
  static const Color accentOrange =
      Color(0xFFFF4D00); // Sunset Orange from image

  // Dark Palette (Teal-Black)
  static const Color darkBackground =
      Color(0xFF000B0D); // Deep Teal-Black for immersive bg
  static const Color darkSurface = Color(0xFF05191D);
  static const Color darkCard =
      Color(0x1A64FFDA); // 10% Cyan-Teal for glassy effect
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xB3FFFFFF); // 70% White
  static const Color auraBaseDark = Color(0xFF000506);

  // Light Palette (kept for compatibility, though dark is now the "standard" futuristic look)
  static const Color lightBackground = Color(0xFFF0F7F8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0x1A000000);
  static const Color lightTextPrimary = Color(0xFF081A1D);
  static const Color lightTextSecondary = Color(0x99081A1D);
  static const Color auraBaseLight = Color(0xFFFAFDFF);

  // Gradients for Vibrancy
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, Color(0xFF0091FF)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryColor, accentOrange],
  );

  // Glass Elements
  static const LinearGradient glassGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x3300F2FF), Color(0x0A00F2FF)],
  );

  // Rounded Corners Standard
  static const double borderRadius = 28.0; // Slightly more rounded for premium feel
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
      textTheme:
          GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: const TextStyle(
            fontWeight: FontWeight.w900, letterSpacing: -2.0, height: 1.1),
        displayMedium: const TextStyle(
            fontWeight: FontWeight.w800, letterSpacing: -1.0, height: 1.2),
        headlineMedium:
            const TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.5),
        titleLarge:
            const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.2),
        bodyLarge: const TextStyle(color: darkTextPrimary, fontSize: 16),
        bodyMedium: const TextStyle(color: darkTextSecondary, fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white, size: 24),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: geometry,
          side: BorderSide(
              color: primaryColor.withValues(alpha: 0.1),
              width: 1.5), // Glassy cyan border
        ),
      ),
      iconTheme: const IconThemeData(color: primaryColor, size: 28),
      pageTransitionsTheme: pageTransitions,
      dividerColor: primaryColor.withValues(alpha: 0.1),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentOrange,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        onSecondary: Colors.white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: darkBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 4,
      ),
    );
  }

  // --- LIGHT THEME DEFINITION ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: primaryColor,
      fontFamily: GoogleFonts.outfit().fontFamily,
      textTheme:
          GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: const TextStyle(
            color: lightTextPrimary,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5),
        headlineMedium: const TextStyle(
            color: lightTextPrimary, fontWeight: FontWeight.w800),
        titleLarge: const TextStyle(
            color: lightTextPrimary, fontWeight: FontWeight.bold),
        bodyLarge: const TextStyle(color: lightTextPrimary),
        bodyMedium: const TextStyle(color: lightTextSecondary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: lightTextPrimary),
        titleTextStyle: TextStyle(
            color: lightTextPrimary, fontSize: 20, fontWeight: FontWeight.w800),
      ),
      cardTheme: CardThemeData(
        color: lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: geometry,
          side: const BorderSide(color: Color(0x1A000000), width: 1),
        ),
      ),
      iconTheme: const IconThemeData(color: primaryColor, size: 28),
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
  static const Color onboardingOrange = accentOrange;
  static const Color pureWhite = Colors.white;
  static const Color pureBlack = Colors.black;
  static const Color surfaceColor = darkSurface;
  static const Color textSecondary = darkTextSecondary;
}
