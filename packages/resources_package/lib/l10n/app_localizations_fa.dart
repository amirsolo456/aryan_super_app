// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'آریان فرانت';

  @override
  String get profileTitle => 'حساب کاربری';

  @override
  String get loginPageTitle => 'صفحه ورود';

  @override
  String get phoneNumber => 'شماره موبایل';

  @override
  String get password => 'رمز عبور';

  @override
  String get passwordValidationNullMsg => 'رمز عبور وارد شده درست نمی باشد.';

  @override
  String get passwordValidationMsg => 'رمز عبور خود را وارد کنید.';

  @override
  String get passwordForgot => 'فراموشی رمز عبور';

  @override
  String get passwordRecovery => 'تکرار رمز عبور';

  @override
  String get personList => 'اشخاص شرکت ها';

  @override
  String get userInfo => 'مشخصات کاربری';

  @override
  String get userPasswordChange => 'تغییر رمز عبور';

  @override
  String get usernameValidationNullMsg => 'نام کاربر یافت نشد!';

  @override
  String get userWallet => 'کیف پول';

  @override
  String get userSettings => 'تنظیمات حساب';

  @override
  String get userOtherAccounts => 'حساب های دیگر';

  @override
  String get usersTitle => 'عنوان حساب';

  @override
  String get usersDevices => 'دستگاه های من';

  @override
  String get usersSignOut => 'خروج از حساب کاربری';

  @override
  String get loginButtonText => 'ورود';

  @override
  String get loginButtonSignUpText => 'ایجاد حساب';

  @override
  String get loginButtonOtpText => 'تایید و ادامه';

  @override
  String get loginButtonLoadingText => 'لطفا صبر کنید';

  @override
  String get loginFailed => 'ورود ناموفق';

  @override
  String languagesDisplayName(String userName) {
    return '';
  }

  @override
  String get userSignupLabel => 'شما در هیچ حسابی عضویت ندارید.\nاگر صاحب یا نماینده یک کسب و کار هستید، میتوانید یک حساب برای [b]کاربر اصلی[/b] یا [b]ادمین شرکت[/b] خودتان بسازید !\nاگر از پرسنل یک کسب و کار هستید، منتظر دریافت دعوتنامه بمانید.';

  @override
  String get userInvitationLabel => 'شخصی با نام [b][نام و نام خانوادگی فرد دعوت کننده][/b] شما را به حساب کاربری [b][نام یا شناسه اکانت/سازمان][/b] دعوت کرده است.\nآیا مایل به تأیید این دعوت و پیوستن به این حساب هستید؟';

  @override
  String get userOtpValidationTitle => 'کد 4رقمی به شماره [5458 202 0912] ارسال شد.';
}
