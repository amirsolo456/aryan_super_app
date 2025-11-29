import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Aryan Front'**
  String get appTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @loginPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Page'**
  String get loginPageTitle;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordValidationNullMsg.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordValidationNullMsg;

  /// No description provided for @passwordValidationMsg.
  ///
  /// In en, this message translates to:
  /// **'Password is NotValid'**
  String get passwordValidationMsg;

  /// No description provided for @passwordForgot.
  ///
  /// In en, this message translates to:
  /// **'Password Forgot'**
  String get passwordForgot;

  /// No description provided for @passwordRecovery.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get passwordRecovery;

  /// No description provided for @personList.
  ///
  /// In en, this message translates to:
  /// **'Person List'**
  String get personList;

  /// No description provided for @userInfo.
  ///
  /// In en, this message translates to:
  /// **'User Info'**
  String get userInfo;

  /// No description provided for @userPasswordChange.
  ///
  /// In en, this message translates to:
  /// **'User Password Change'**
  String get userPasswordChange;

  /// No description provided for @usernameValidationNullMsg.
  ///
  /// In en, this message translates to:
  /// **'User Not Found!'**
  String get usernameValidationNullMsg;

  /// No description provided for @userWallet.
  ///
  /// In en, this message translates to:
  /// **'User Wallet'**
  String get userWallet;

  /// No description provided for @userSettings.
  ///
  /// In en, this message translates to:
  /// **'User Settings'**
  String get userSettings;

  /// No description provided for @userOtherAccounts.
  ///
  /// In en, this message translates to:
  /// **'Other Accounts'**
  String get userOtherAccounts;

  /// No description provided for @usersTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Title'**
  String get usersTitle;

  /// No description provided for @usersDevices.
  ///
  /// In en, this message translates to:
  /// **'My Devices'**
  String get usersDevices;

  /// No description provided for @usersSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out From Account'**
  String get usersSignOut;

  /// No description provided for @loginButtonText.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButtonText;

  /// No description provided for @loginButtonSignUpText.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get loginButtonSignUpText;

  /// No description provided for @loginButtonOtpText.
  ///
  /// In en, this message translates to:
  /// **'Confirm and Continue'**
  String get loginButtonOtpText;

  /// No description provided for @loginButtonLoadingText.
  ///
  /// In en, this message translates to:
  /// **'Please Waite ...'**
  String get loginButtonLoadingText;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailed;

  /// English
  ///
  /// In en, this message translates to:
  /// **''**
  String languagesDisplayName(String userName);

  /// No description provided for @userSignupLabel.
  ///
  /// In en, this message translates to:
  /// **'You are not a member of any account.\nIf you are the owner or a representative of a business, you can create an account for your [b]main user[/b] or [b]company admin[/b]!\nIf you are an employee of a business, please wait to receive an invitation.'**
  String get userSignupLabel;

  /// No description provided for @userInvitationLabel.
  ///
  /// In en, this message translates to:
  /// **'A person named [b][Inviter\'s Full Name][/b] has invited you to the account [b][Account Name or ID][/b].\nWould you like to accept this invitation and join this account?\n'**
  String get userInvitationLabel;

  /// No description provided for @userOtpValidationTitle.
  ///
  /// In en, this message translates to:
  /// **'A 4-digit code has been sent to the number [0912 202 5458].\n'**
  String get userOtpValidationTitle;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fa': return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
