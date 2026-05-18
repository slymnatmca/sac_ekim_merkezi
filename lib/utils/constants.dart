// Uygulama sabitleri
class AppConstants {
  // Responsive breakpoints
  static const double phoneMaxWidth = 600;
  static const double tabletMaxWidth = 900;
  
  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  // Border radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  
  // Hafta sayısı
  static const int totalWeeks = 16;
  
  // Shared Preferences Keys
  static const String keyUser = 'user';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLocale = 'locale';
  
  // User Types
  static const String userTypePatient = 'patient';
  static const String userTypeDoctor = 'doctor';
  
  // Premium
  static const double premiumPrice = 99.99;
  
  // Image
  static const int maxImageSizeMB = 5;
  
  // Animation durations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 500);
}
