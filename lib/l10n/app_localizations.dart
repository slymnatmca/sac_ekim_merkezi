import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Hair Transplant Clinic'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @basic.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get basic;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgrade;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @careGuide.
  ///
  /// In en, this message translates to:
  /// **'Care Guide'**
  String get careGuide;

  /// No description provided for @consultation.
  ///
  /// In en, this message translates to:
  /// **'Consultation'**
  String get consultation;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @transplantDate.
  ///
  /// In en, this message translates to:
  /// **'Transplant Date'**
  String get transplantDate;

  /// No description provided for @currentWeek.
  ///
  /// In en, this message translates to:
  /// **'Current Week'**
  String get currentWeek;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addNote;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @answered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get answered;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @doctorComment.
  ///
  /// In en, this message translates to:
  /// **'Doctor\'s Comment'**
  String get doctorComment;

  /// No description provided for @patientNote.
  ///
  /// In en, this message translates to:
  /// **'Patient\'s Note'**
  String get patientNote;

  /// No description provided for @noCommentYet.
  ///
  /// In en, this message translates to:
  /// **'No comment yet'**
  String get noCommentYet;

  /// No description provided for @premiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Premium Features'**
  String get premiumFeatures;

  /// No description provided for @liveChat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat with Doctor'**
  String get liveChat;

  /// No description provided for @unlimitedPhotos.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Photo Uploads'**
  String get unlimitedPhotos;

  /// No description provided for @prioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority Support'**
  String get prioritySupport;

  /// No description provided for @buyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buyNow;

  /// No description provided for @selectDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Doctor'**
  String get selectDoctor;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @isPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium Account'**
  String get isPremium;

  /// No description provided for @totalPatients.
  ///
  /// In en, this message translates to:
  /// **'Total Patients'**
  String get totalPatients;

  /// No description provided for @unansweredConsultations.
  ///
  /// In en, this message translates to:
  /// **'Unanswered Consultations'**
  String get unansweredConsultations;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get loginError;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @week1Title.
  ///
  /// In en, this message translates to:
  /// **'Week 1-2: First Days'**
  String get week1Title;

  /// No description provided for @week1Desc.
  ///
  /// In en, this message translates to:
  /// **'Critical first days after hair transplant. No washing, proper sleep position.'**
  String get week1Desc;

  /// No description provided for @week1Tips.
  ///
  /// In en, this message translates to:
  /// **'• Do not touch the transplanted area\n• Sleep with head elevated\n• Avoid direct sunlight\n• Take prescribed medications'**
  String get week1Tips;

  /// No description provided for @week3Title.
  ///
  /// In en, this message translates to:
  /// **'Week 3-4: First Wash'**
  String get week3Title;

  /// No description provided for @week3Desc.
  ///
  /// In en, this message translates to:
  /// **'First washing period and scab formation.'**
  String get week3Desc;

  /// No description provided for @week3Tips.
  ///
  /// In en, this message translates to:
  /// **'• Gentle washing with special shampoo\n• Scabs will start to fall\n• Avoid scratching\n• Continue sun protection'**
  String get week3Tips;

  /// No description provided for @week5Title.
  ///
  /// In en, this message translates to:
  /// **'Week 5-8: Shock Loss'**
  String get week5Title;

  /// No description provided for @week5Desc.
  ///
  /// In en, this message translates to:
  /// **'Temporary hair shedding period - completely normal.'**
  String get week5Desc;

  /// No description provided for @week5Tips.
  ///
  /// In en, this message translates to:
  /// **'• Don\'t worry about shedding\n• This is a natural process\n• New hair will grow\n• Maintain healthy diet'**
  String get week5Tips;

  /// No description provided for @week9Title.
  ///
  /// In en, this message translates to:
  /// **'Week 9-12: New Growth'**
  String get week9Title;

  /// No description provided for @week9Desc.
  ///
  /// In en, this message translates to:
  /// **'New hair starts to emerge.'**
  String get week9Desc;

  /// No description provided for @week9Tips.
  ///
  /// In en, this message translates to:
  /// **'• New hair will be thin initially\n• Be patient\n• Continue care routine\n• Stay hydrated'**
  String get week9Tips;

  /// No description provided for @week13Title.
  ///
  /// In en, this message translates to:
  /// **'Week 13-16: Growth & Care'**
  String get week13Title;

  /// No description provided for @week13Desc.
  ///
  /// In en, this message translates to:
  /// **'Hair continues to grow and strengthen.'**
  String get week13Desc;

  /// No description provided for @week13Tips.
  ///
  /// In en, this message translates to:
  /// **'• Hair will thicken over time\n• Regular trimming is okay\n• Use gentle hair products\n• Maintain healthy lifestyle'**
  String get week13Tips;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
