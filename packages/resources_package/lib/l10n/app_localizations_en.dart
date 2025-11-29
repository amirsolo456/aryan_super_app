// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Aryan Front';

  @override
  String get profileTitle => 'Profile';

  @override
  String get loginPageTitle => 'Login Page';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get password => 'Password';

  @override
  String get passwordValidationNullMsg => 'Password is required';

  @override
  String get passwordValidationMsg => 'Password is NotValid';

  @override
  String get passwordForgot => 'Password Forgot';

  @override
  String get passwordRecovery => 'Repeat Password';

  @override
  String get personList => 'Person List';

  @override
  String get userInfo => 'User Info';

  @override
  String get userPasswordChange => 'User Password Change';

  @override
  String get usernameValidationNullMsg => 'User Not Found!';

  @override
  String get userWallet => 'User Wallet';

  @override
  String get userSettings => 'User Settings';

  @override
  String get userOtherAccounts => 'Other Accounts';

  @override
  String get usersTitle => 'Account Title';

  @override
  String get usersDevices => 'My Devices';

  @override
  String get usersSignOut => 'Sign Out From Account';

  @override
  String get loginButtonText => 'Login';

  @override
  String get loginButtonSignUpText => 'Create Account';

  @override
  String get loginButtonOtpText => 'Confirm and Continue';

  @override
  String get loginButtonLoadingText => 'Please Waite ...';

  @override
  String get loginFailed => 'Login Failed';

  @override
  String languagesDisplayName(String userName) {
    return '';
  }

  @override
  String get userSignupLabel => 'You are not a member of any account.\nIf you are the owner or a representative of a business, you can create an account for your [b]main user[/b] or [b]company admin[/b]!\nIf you are an employee of a business, please wait to receive an invitation.';

  @override
  String get userInvitationLabel => 'A person named [b][Inviter\'s Full Name][/b] has invited you to the account [b][Account Name or ID][/b].\nWould you like to accept this invitation and join this account?\n';

  @override
  String get userOtpValidationTitle => 'A 4-digit code has been sent to the number [0912 202 5458].\n';
}
