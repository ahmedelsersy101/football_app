import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Sport Navy
  static const Color primary = Color(0xFF0A2A43);
  static const Color primaryLight = Color(0xFF1E3F58);
  static const Color primaryDark = Color(0xFF061E30);

  // Accent Colors - Neon Green
  static const Color accent = Color(0xFF00E676);
  static const Color accentLight = Color(0xFF69F0AE);
  static const Color accentDark = Color(0xFF00C853);

  // Light Theme Background Colors
  static const Color background = Color(0xFFF9F9F9);
  static const Color backgroundSecondary = Color(0xFFF1F1F1);
  static const Color surface = Color(0xFFFFFFFF);

  // Light Theme Text Colors
  static const Color textPrimary = Color(0xFF0A2A43);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFF000000);

  // Dark Theme Background Colors
  static const Color darkBackground = Color(0xFF0C0C0C);
  static const Color darkBackgroundSecondary = Color(0xFF141414);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkSurfaceVariant = Color(0xFF222222);

  // Dark Theme Text Colors
  static const Color darkTextPrimary = Color(0xFFEAEAEA);
  static const Color darkTextSecondary = Color(0xFFB8B8B8);
  static const Color darkTextTertiary = Color(0xFF8E8E8E);
  static const Color darkTextOnPrimary = Color(0xFFFFFFFF);
  static const Color darkTextOnSurface = Color(0xFFEAEAEA);

  // Status Colors (Shared)
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFFB300);
  static const Color error = Color(0xFFD50000);
  static const Color info = Color(0xFF00B0FF);

  // Dark Theme Status Colors
  static const Color darkSuccess = Color(0xFF69F0AE);
  static const Color darkWarning = Color(0xFFFFCC80);
  static const Color darkError = Color(0xFFFF5252);
  static const Color darkInfo = Color(0xFF40C4FF);

  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  // Light Theme Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accentDark],
  );

  // Dark Theme Gradient Colors
  static const LinearGradient darkPrimaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primary],
  );

  static const LinearGradient darkAccentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentDark, accent],
  );

  static const LinearGradient darkSurfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkSurface, darkSurfaceVariant],
  );
}
