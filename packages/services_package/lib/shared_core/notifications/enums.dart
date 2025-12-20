// ========== انواع نوتیفیکیشن‌ها ==========
enum NotificationType {
  // Authentication
  authRequired,
  sessionExpired,
  forceLogout,
  loginSuccess,
  loginFailed,

  // Data Operations
  dataUpdated,
  dataCreated,
  dataDeleted,
  dataSyncRequired,
  genericListRefresh,

  // Business Entities
  personDataChanged,
  invoiceDataChanged,
  orderDataChanged,
  customerDataChanged,
  productDataChanged,

  // Settings
  languageChanged,
  currencyChanged,
  yearChanged,
  placeChanged,
  cashierChanged,

  // UI & Navigation
  menuUpdated,
  navigationChanged,
  themeChanged,
  appBarChanged,

  // Network & Connectivity
  networkStatusChanged,
  connectionLost,
  connectionRestored,
  serverUnreachable,

  // System & Errors
  errorOccurred,
  warningMessage,
  successMessage,
  infoMessage,
  debugMessage,

  // App State
  appStarted,
  appResumed,
  appPaused,
  appInBackground,

  // Custom
  customEvent,
}

// ========== Priority Levels ==========
enum NotificationPriority {
  low, // Info, debug
  normal, // Normal operations
  high, // Important updates
  urgent, // Requires immediate attention
  critical, // App-breaking issues
}

enum CrossAppDirection { toParent, toChild, both, none }
