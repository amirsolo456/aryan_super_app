enum AppBarsMode {
  erpNewMode(0),
  erpMenuMode(1),
  erpOpenedMode(2),
  erpDefaultMode(3),
  erpProfileMode(4),
  erpGenericList(5),
  erpGenericForm(6),
  erpNotFound(7),
  erpDashboardMode(10);

  final int value;

  const AppBarsMode(this.value);
}

enum NavButtonTabBarMode {
  erpMenuTabMode(0),
  erpNewTabMode(1),
  erpOpenedTabMode(2),
  erpDefaultTabMode(3),
  erpProfileTabMode(4),
  erpGenericListTabMode(5),
  erpGenericFormTabMode(6),
  erpNotFound(7),
  skeletion(8),
  erpDashboardTabMode(10);

  final int value;

  const NavButtonTabBarMode(this.value);
}

enum SessionKeys {
  user,
  token,
  selectedManagement,
  managementAccount,
  resultType,
  error,
  success,
  loginResult,
  networkType,
  language,
  timeStamp,
  deviceToken,
}

extension SessionKeysExt on SessionKeys {
  String get key {
    switch (this) {
      case SessionKeys.user:
        return "User";
      case SessionKeys.token:
        return "Token";
      case SessionKeys.managementAccount:
        return "ManagementAccount";
      case SessionKeys.success:
        return "Success";
      case SessionKeys.resultType:
        return "ResultType";
      case SessionKeys.error:
        return "Error";
      case SessionKeys.networkType:
        return "NetworkType";
      case SessionKeys.timeStamp:
        return "Timestamp";
      case SessionKeys.selectedManagement:
        return "SelectedManagementAccount";
      case SessionKeys.loginResult:
        return "loginResult";
      case SessionKeys.language:
        return "Language";
      case SessionKeys.deviceToken:
        return "DeviceToken";
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
