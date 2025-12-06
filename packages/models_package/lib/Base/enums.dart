enum AppBarsMode {
  erpPersonListMode(0),
  erpNewMode(1),
  erpOpendMode(2),
  erpdefaultMode(3),
  erpprofileMode(4),
  erpdashboardMode(10);

  final int value;

  const AppBarsMode(this.value);
}

enum NavButtonTabBarMode {
  menuTabMode(0),
  newTabMode(1),
  openedTabMode(2),
  defaultTabMode(3),
  profileTabMode(4),
  dashboardTabMode(10);

  final int value;

  const NavButtonTabBarMode(this.value);
}

enum SessionKeys { user, token, selectedManagement, loginResult, language }

extension SessionKeysExt on SessionKeys {
  String get key {
    switch (this) {
      case SessionKeys.user:
        return "user";
      case SessionKeys.token:
        return "token";
      case SessionKeys.selectedManagement:
        return "selectedManagement";
      case SessionKeys.loginResult:
        return "loginResult";
      case SessionKeys.language:
        return "language";
    }
  }
}

enum LoginResultType {
  success,
  error,
  cancelled,
  networkError,
  validationError,
  managementAccountPick,
}

enum MessageMode {
  successMode,
  errorMode,
  infoMode,
  questionBoxMode,
  defaultMode,
}

enum OpenedType { none, open, save, error, approve, reject }

enum FormType {
  list(0),
  form(1),
  app(2);

  final int value;

  const FormType(this.value);
}

enum OpenedDataType { string, int, bool, date }

enum NetworkMode { live, simulatedSuccess, simulatedError }
