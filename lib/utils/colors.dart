import 'package:flutter/material.dart';

class AppColors {
  // Modern Primary Colors - Teal/Turquoise (Medical & Trust)
  static const Color primaryLight = Color(0xFF00897B);
  static const Color primaryDark = Color(0xFF00695C);
  static const Color primaryAccent = Color(0xFF26A69A);
  
  // Secondary Colors - Purple (Premium & Elegance)
  static const Color secondaryLight = Color(0xFF7E57C2);
  static const Color secondaryDark = Color(0xFF5E35B1);
  static const Color secondaryAccent = Color(0xFF9575CD);
  
  // Premium Colors - Gold Gradient
  static const Color premiumGold = Color(0xFFFFB300);
  static const Color premiumGoldLight = Color(0xFFFFCA28);
  static const Color premiumGoldDark = Color(0xFFFF8F00);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00897B), Color(0xFF26A69A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF7E57C2), Color(0xFF9575CD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFFFFB300), Color(0xFFFFCA28), Color(0xFFFF8F00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient doctorGradient = LinearGradient(
    colors: [Color(0xFF5E35B1), Color(0xFF7E57C2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Background Colors - Light
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  
  // Background Colors - Dark
  static const Color backgroundDark = Color(0xFF0A0E27);
  static const Color surfaceDark = Color(0xFF1A1F3A);
  static const Color cardDark = Color(0xFF252B48);
  
  // Text Colors - Light
  static const Color textPrimaryLight = Color(0xFF1A1A2E);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  
  // Text Colors - Dark
  static const Color textPrimaryDark = Color(0xFFF3F4F6);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  
  // Status Colors - Modern
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Consultation Status
  static const Color answered = Color(0xFF10B981);
  static const Color pending = Color(0xFFF59E0B);
  
  // Week Progress Colors
  static const Color week1Color = Color(0xFFEF4444);
  static const Color week4Color = Color(0xFFF59E0B);
  static const Color week8Color = Color(0xFF3B82F6);
  static const Color week12Color = Color(0xFF8B5CF6);
  static const Color week16Color = Color(0xFF10B981);
  
  // Accent Colors
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentPink = Color(0xFFEC4899);
  static const Color accentGreen = Color(0xFF10B981);
}
