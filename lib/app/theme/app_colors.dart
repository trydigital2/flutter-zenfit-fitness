import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Primary & Accent
  static const Color primary = Color(0xFF133E2B); // Deep Forest Green
  static const Color primaryDark = Color(0xFF0C271B);
  static const Color primaryLight = Color(0xFF1E563E);
  static const Color primaryContainer = Color(0xFFE3EFE8);

  static const Color accent = Color(0xFF9FE870); // Energetic Lime Green
  static const Color accentLight = Color(0xFFC7FFA3);
  static const Color accentDark = Color(0xFF74BD42);
  static const Color accentContainer = Color(0xFFEBFCE3);

  // Light Theme Neutrals
  static const Color lightBg = Color(0xFFF7FAF7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2EBE4);
  static const Color lightDivider = Color(0xFFE9F0EB);
  static const Color lightTextPrimary = Color(0xFF131C16);
  static const Color lightTextSecondary = Color(0xFF53675A);
  static const Color lightTextMuted = Color(0xFF889C90);

  // Dark Theme Neutrals
  static const Color darkBg = Color(0xFF0D1410);
  static const Color darkSurface = Color(0xFF141D17);
  static const Color darkCard = Color(0xFF1B2620);
  static const Color darkBorder = Color(0xFF283A30);
  static const Color darkDivider = Color(0xFF223028);
  static const Color darkTextPrimary = Color(0xFFF3F7F4);
  static const Color darkTextSecondary = Color(0xFFA1B5A9);
  static const Color darkTextMuted = Color(0xFF6B8073);

  // Functional & Metric Colors
  static const Color caloriesOrange = Color(0xFFFF6D43);
  static const Color waterBlue = Color(0xFF0EA5E9);
  static const Color heartRed = Color(0xFFF43F5E);
  static const Color mindfulPurple = Color(0xFFA855F7);
  static const Color streakGold = Color(0xFFF59E0B);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1E563E), Color(0xFF103625)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFAEF47D), Color(0xFF81D147)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1D2821), Color(0xFF141E18)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroCardGradient = LinearGradient(
    colors: [Color(0xFF1B4D3E), Color(0xFF0D2A20)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
