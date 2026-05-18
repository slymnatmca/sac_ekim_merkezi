import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  // Tarih formatlama
  static String formatDate(DateTime date, {String? locale}) {
    return DateFormat('dd MMM yyyy', locale).format(date);
  }
  
  static String formatDateTime(DateTime date, {String? locale}) {
    return DateFormat('dd MMM yyyy HH:mm', locale).format(date);
  }
  
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }
  
  // Ekim tarihinden kaç hafta geçtiğini hesapla
  static int calculateWeeksSinceTransplant(DateTime transplantDate) {
    final now = DateTime.now();
    final difference = now.difference(transplantDate);
    return (difference.inDays / 7).floor() + 1;
  }
  
  // Responsive helper
  static bool isPhone(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 900;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900;
  }
  
  // Grid column sayısı
  static int getGridColumns(BuildContext context) {
    if (isDesktop(context)) return 3;
    if (isTablet(context)) return 2;
    return 1;
  }
  
  // Snackbar göster
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
  // Email validasyonu
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  // Şifre validasyonu (minimum 6 karakter)
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }
}
