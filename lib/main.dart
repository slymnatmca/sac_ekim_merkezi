import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/patient_provider.dart';
import 'providers/doctor_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/chat_provider.dart';

import 'services/firebase_init_data.dart';

import 'utils/theme.dart';

import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/patient/patient_dashboard_screen.dart';
import 'screens/patient/patient_profile_screen.dart';
import 'screens/patient/care_guide_screen.dart';
import 'screens/patient/consultation_screen.dart';
import 'screens/patient/chat_screen.dart';
import 'screens/doctor/doctor_dashboard_screen.dart';
import 'screens/doctor/doctor_profile_screen.dart';
import 'screens/doctor/patient_detail_screen.dart';
import 'screens/doctor/doctor_chat_list_screen.dart';
import 'screens/premium/premium_upgrade_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // İlk çalıştırmada test verilerini yükle (sadece bir kez çalıştırın!)
  // await FirebaseInitData.initializeTestData();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Hair Transplant Clinic',
      debugShowCheckedModeBanner: false,
      
      // Tema
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // Localization
      locale: localeProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
      ],
      
      // Builder to ensure proper keyboard behavior
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      
      // Routing
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/patient-dashboard': (context) => const PatientDashboardScreen(),
        '/patient-profile': (context) => const PatientProfileScreen(),
        '/care-guide': (context) => const CareGuideScreen(),
        '/consultation': (context) => const ConsultationScreen(),
        '/chat': (context) => const ChatScreen(),
        '/doctor-dashboard': (context) => const DoctorDashboardScreen(),
        '/doctor-profile': (context) => const DoctorProfileScreen(),
        '/patient-detail': (context) => const PatientDetailScreen(),
        '/doctor-chat-list': (context) => const DoctorChatListScreen(),
        '/premium': (context) => const PremiumUpgradeScreen(),
      },
    );
  }
}
