// ========== مدل داده نوتیفیکیشن ==========
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'enums.dart';

class AppNotification {
  final String id;
  final NotificationType type;
  final NotificationPriority priority;
  final String? title;
  final String? message;
  final dynamic payload;
  final DateTime timestamp;
  final String source;
  final CrossAppDirection crossAppDirection;
  final bool isConsumed;
  final Map<String, dynamic>? metadata;

  AppNotification({
    required this.type,
    this.priority = NotificationPriority.normal,
    this.title,
    this.message,
    this.payload,
    String? source,
    this.metadata,
    String? id,
    required this.crossAppDirection,
  }) : id = id ?? '${DateTime.now().millisecondsSinceEpoch}_${type.name}',
       timestamp = DateTime.now(),
       source = source ?? 'unknown',
       isConsumed = false;

  // Factory برای ایجاد از JSON (برای ارتباط بین پروسه‌ها)
  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.customEvent,
      ),
      priority: NotificationPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => NotificationPriority.normal,
      ),
      title: json['title'],
      message: json['message'],
      payload: json['payload'],
      source: json['source'],
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
      crossAppDirection: CrossAppDirection.both,
    );
  }

  // تبدیل به JSON (برای ارتباط بین پروسه‌ها)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'priority': priority.name,
      'title': title,
      'message': message,
      'payload': payload,
      'timestamp': timestamp.toIso8601String(),
      'source': source,
      'isConsumed': isConsumed,
      'metadata': metadata,
    };
  }

  // کپی با تغییرات
  AppNotification copyWith({
    NotificationType? type,
    NotificationPriority? priority,
    String? title,
    String? message,
    dynamic payload,
    String? source,
    bool? isConsumed,
    Map<String, dynamic>? metadata,
    required CrossAppDirection crossApp,
  }) {
    return AppNotification(
      id: id,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      title: title ?? this.title,
      message: message ?? this.message,
      payload: payload ?? this.payload,
      source: source ?? this.source,
      metadata: metadata ?? this.metadata,
      crossAppDirection: crossApp,
    );
  }

  @override
  String toString() {
    return 'AppNotification{id: $id, type: $type, priority: $priority, source: $source, message: $message}';
  }
}

// ========== اینترفیس Listenerها ==========
typedef NotificationListener = void Function(AppNotification notification);
typedef TypedNotificationListener<T> = void Function(T payload);

// ========== کلاس اصلی AppNotifier ==========
class AppNotifier {
  static AppNotifier? _instance;
  MethodChannel? _parentChannel;
  MethodChannel? _childChannel;

  // StreamController برای reactive programming
  final StreamController<AppNotification> _notificationStream =
      StreamController<AppNotification>.broadcast();

  // StreamController برای انواع خاص
  final Map<NotificationType, StreamController<AppNotification>> _typedStreams =
      {};

  // لیست listenerهای مستقیم
  final Map<String, NotificationListener> _directListeners = {};

  // کانال‌های خاص برای انواع مختلف نوتیفیکیشن
  final Map<NotificationType, List<NotificationListener>> _typedListeners = {};

  // نگه‌داری آخرین نوتیفیکیشن‌ها
  final List<AppNotification> _notificationHistory = [];
  static const int _maxHistorySize = 500;

  // نگه‌داری نوتیفیکیشن‌های مصرف نشده
  final Map<NotificationType, List<AppNotification>> _unconsumedNotifications =
      {};

  // برای ارتباط بین اپ پدر و فرزند (با استفاده از MethodChannel)
  final Map<String, Completer<dynamic>> _pendingRequests = {};
  final Map<String, StreamController<AppNotification>> _crossAppStreams = {};

  void _sendToOtherApp(
    AppNotification notification,
    CrossAppDirection direction,
  ) {
    if (direction == CrossAppDirection.toParent && _parentChannel != null) {
      _parentChannel!.invokeMethod('notification', notification.toJson());
    } else if (direction == CrossAppDirection.toChild &&
        _childChannel != null) {
      _childChannel!.invokeMethod('notification', notification.toJson());
    }
  }

  // سازنده خصوصی برای Singleton
  AppNotifier._internal() {
    _initializeCrossAppCommunication();
  }

  factory AppNotifier() {
    _instance ??= AppNotifier._internal();
    return _instance!;
  }

  // ========== Initialize در GetIt ==========
  static void initialize({bool registerInGetIt = true, required dynamic sl}) {
    if (registerInGetIt) {
      sl.registerSingleton<AppNotifier>(AppNotifier());
    }
  }

  // ========== Getters ==========
  Stream<AppNotification> get notifications => _notificationStream.stream;

  Stream<AppNotification> typedStream(NotificationType type) {
    return _typedStreams
        .putIfAbsent(type, () => StreamController<AppNotification>.broadcast())
        .stream;
  }

  List<AppNotification> get notificationHistory =>
      List.unmodifiable(_notificationHistory);

  List<AppNotification> getUnconsumedNotifications(NotificationType type) {
    return List.unmodifiable(_unconsumedNotifications[type] ?? []);
  }

  // ========== ارسال نوتیفیکیشن ==========
  String notify({
    required NotificationType type,
    NotificationPriority priority = NotificationPriority.normal,
    String? title,
    String? message,
    dynamic payload,
    String? source,
    Map<String, dynamic>? metadata,
    bool crossApp = false, // آیا به اپ دیگر هم ارسال شود؟
  }) {
    final notification = AppNotification(
      type: type,
      priority: priority,
      title: title,
      message: message,
      payload: payload,
      source: source,
      metadata: metadata,
      crossAppDirection: CrossAppDirection.both,
    );

    // ذخیره در تاریخچه
    _addToHistory(notification);

    // ذخیره به عنوان مصرف نشده
    _addToUnconsumed(notification);

    // انتشار از طریق Stream عمومی
    _notificationStream.add(notification);

    // انتشار از طریق Stream تایپ‌دار
    _notifyTypedStreams(notification);

    // فراخوانی listenerهای مستقیم
    _notifyDirectListeners(notification);

    // فراخوانی listenerهای تایپ‌دار
    _notifyTypedListeners(notification);

    // ارسال به اپ دیگر اگر لازم باشد
    if (crossApp) {
      _sendToOtherApp(notification, CrossAppDirection.both);
    }

    if (kDebugMode) {
      print('📢 AppNotifier: $notification');
    }

    return notification.id;
  }

  // ========== ثبت Listener ==========
  String addListener(NotificationListener listener, {String? key}) {
    final listenerKey =
        key ?? 'listener_${DateTime.now().millisecondsSinceEpoch}';
    _directListeners[listenerKey] = listener;
    return listenerKey;
  }

  void removeListener(String key) {
    _directListeners.remove(key);
  }

  void addTypedListener(NotificationType type, NotificationListener listener) {
    _typedListeners.putIfAbsent(type, () => []).add(listener);
  }

  void removeTypedListener(
    NotificationType type,
    NotificationListener listener,
  ) {
    final listeners = _typedListeners[type];
    if (listeners != null) {
      listeners.remove(listener);
      if (listeners.isEmpty) {
        _typedListeners.remove(type);
      }
    }
  }

  // ========== متدهای کمکی برای نوتیفیکیشن‌های پرکاربرد ==========
  String notifySuccess(
    String message, {
    String? title,
    dynamic payload,
    String? source,
    bool crossApp = false,
  }) {
    return notify(
      type: NotificationType.successMessage,
      priority: NotificationPriority.high,
      title: title ?? 'موفقیت',
      message: message,
      payload: payload,
      source: source,
      crossApp: crossApp,
    );
  }

  String notifyError(
    String message, {
    String? title,
    dynamic payload,
    String? source,
    bool crossApp = true, // خطاها معمولاً به اپ پدر هم ارسال می‌شوند
  }) {
    return notify(
      type: NotificationType.errorOccurred,
      priority: NotificationPriority.urgent,
      title: title ?? 'خطا',
      message: message,
      payload: payload,
      source: source,
      crossApp: crossApp,
    );
  }

  String notifyWarning(
    String message, {
    String? title,
    dynamic payload,
    String? source,
    bool crossApp = false,
  }) {
    return notify(
      type: NotificationType.warningMessage,
      priority: NotificationPriority.high,
      title: title ?? 'هشدار',
      message: message,
      payload: payload,
      source: source,
      crossApp: crossApp,
    );
  }

  String notifyInfo(
    String message, {
    String? title,
    dynamic payload,
    String? source,
    bool crossApp = false,
  }) {
    return notify(
      type: NotificationType.infoMessage,
      priority: NotificationPriority.normal,
      title: title ?? 'اطلاعیه',
      message: message,
      payload: payload,
      source: source,
      crossApp: crossApp,
    );
  }

  // ========== نوتیفیکیشن‌های خاص ==========
  String notifySessionExpired({String? message, bool crossApp = true}) {
    return notify(
      type: NotificationType.sessionExpired,
      priority: NotificationPriority.critical,
      title: 'انقضای سشن',
      message: message ?? 'سشن شما منقضی شده است',
      crossApp: crossApp,
    );
  }

  String notifyAuthRequired({String? message, bool crossApp = true}) {
    return notify(
      type: NotificationType.authRequired,
      priority: NotificationPriority.critical,
      title: 'نیاز به احراز هویت',
      message: message ?? 'لطفاً مجدداً وارد شوید',
      crossApp: crossApp,
    );
  }

  String notifyForceLogout({String? message, bool crossApp = true}) {
    return notify(
      type: NotificationType.forceLogout,
      priority: NotificationPriority.critical,
      title: 'خروج اجباری',
      message: message ?? 'شما از سیستم خارج شدید',
      crossApp: crossApp,
    );
  }

  String notifyDataUpdated(
    String entity, {
    dynamic payload,
    bool crossApp = true,
  }) {
    return notify(
      type: NotificationType.dataUpdated,
      title: 'بروزرسانی داده',
      message: 'داده‌های $entity بروزرسانی شدند',
      payload: payload ?? {'entity': entity},
      crossApp: crossApp,
    );
  }

  // ========== مدیریت مصرف نوتیفیکیشن‌ها ==========
  void markAsConsumed(String notificationId) {
    final index = _notificationHistory.indexWhere(
      (n) => n.id == notificationId,
    );
    if (index != -1) {
      final notification = _notificationHistory[index];
      _notificationHistory[index] = notification.copyWith(
        isConsumed: true,
        crossApp: CrossAppDirection.both,
      );

      // حذف از لیست مصرف نشده‌ها
      _unconsumedNotifications[notification.type]?.removeWhere(
        (n) => n.id == notificationId,
      );
    }
  }

  void markAllAsConsumed(NotificationType type) {
    for (final notification in _notificationHistory) {
      if (notification.type == type) {
        final index = _notificationHistory.indexWhere(
          (n) => n.id == notification.id,
        );
        if (index != -1) {
          _notificationHistory[index] = notification.copyWith(
            isConsumed: true,
            crossApp: CrossAppDirection.both,
          );
        }
      }
    }

    _unconsumedNotifications.remove(type);
  }

  // ========== جستجو در تاریخچه ==========
  AppNotification? getLastNotificationByType(NotificationType type) {
    return _notificationHistory.where((n) => n.type == type).lastOrNull;
  }

  List<AppNotification> getNotificationsByType(NotificationType type) {
    return _notificationHistory.where((n) => n.type == type).toList();
  }

  List<AppNotification> getNotificationsBySource(String source) {
    return _notificationHistory.where((n) => n.source == source).toList();
  }

  List<AppNotification> getUnreadNotifications({int? limit}) {
    final unread = _notificationHistory.where((n) => !n.isConsumed).toList();

    return limit != null && limit < unread.length
        ? unread.sublist(0, limit)
        : unread;
  }

  // ========== پاک کردن ==========
  void clearHistory() {
    _notificationHistory.clear();
    _unconsumedNotifications.clear();
  }

  void clearByType(NotificationType type) {
    _notificationHistory.removeWhere((n) => n.type == type);
    _unconsumedNotifications.remove(type);
  }

  void clearBySource(String source) {
    _notificationHistory.removeWhere((n) => n.source == source);
    for (final key in _unconsumedNotifications.keys) {
      _unconsumedNotifications[key]?.removeWhere((n) => n.source == source);
    }
  }

  // ========== ارتباط بین اپ پدر و فرزند ==========
  Future<dynamic> sendRequestToOtherApp({
    required String method,
    dynamic params,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final completer = Completer<dynamic>();
    final requestId = 'req_${DateTime.now().millisecondsSinceEpoch}';

    _pendingRequests[requestId] = completer;

    // اینجا باید با Platform Channel به اپ دیگر پیام بفرستید
    // این یک پیاده‌سازی نمونه است
    try {
      // در واقعیت: await MethodChannel('app_communication').invokeMethod(method, params);
      // برای نمونه، یک پیاده‌سازی شبیه‌سازی:
      _simulateCrossAppRequest(requestId, method, params);

      // تایم‌اوت
      Future.delayed(timeout, () {
        if (!completer.isCompleted) {
          completer.completeError(TimeoutException('Request timeout'));
          _pendingRequests.remove(requestId);
        }
      });

      return await completer.future;
    } catch (e) {
      _pendingRequests.remove(requestId);
      rethrow;
    }
  }

  void receiveFromOtherApp(Map<String, dynamic> data) {
    try {
      if (data['type'] == 'notification') {
        final notification = AppNotification.fromJson(data['notification']);
        // انتشار در اپ فعلی
        _notificationStream.add(notification);
        _addToHistory(notification);
      } else if (data['type'] == 'response') {
        final requestId = data['requestId'];
        final result = data['result'];
        final completer = _pendingRequests[requestId];

        if (completer != null && !completer.isCompleted) {
          if (data.containsKey('error')) {
            completer.completeError(data['error']);
          } else {
            completer.complete(result);
          }
          _pendingRequests.remove(requestId);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error receiving from other app: $e');
      }
    }
  }

  // ========== متدهای خصوصی ==========
  void _addToHistory(AppNotification notification) {
    _notificationHistory.add(notification);
    if (_notificationHistory.length > _maxHistorySize) {
      _notificationHistory.removeAt(0);
    }
  }

  void _addToUnconsumed(AppNotification notification) {
    if (!notification.isConsumed) {
      _unconsumedNotifications
          .putIfAbsent(notification.type, () => [])
          .add(notification);
    }
  }

  void _notifyDirectListeners(AppNotification notification) {
    final listeners = Map<String, NotificationListener>.from(_directListeners);
    for (final listener in listeners.values) {
      try {
        listener(notification);
      } catch (e) {
        if (kDebugMode) {
          print('Error in direct notification listener: $e');
        }
      }
    }
  }

  void _notifyTypedListeners(AppNotification notification) {
    final listeners = _typedListeners[notification.type];
    if (listeners != null) {
      final copy = List<NotificationListener>.from(listeners);
      for (final listener in copy) {
        try {
          listener(notification);
        } catch (e) {
          if (kDebugMode) {
            print('Error in typed notification listener: $e');
          }
        }
      }
    }
  }

  void _notifyTypedStreams(AppNotification notification) {
    final streamController = _typedStreams[notification.type];
    if (streamController != null && !streamController.isClosed) {
      streamController.add(notification);
    }
  }

  void _initializeCrossAppCommunication() {
    // در اینجا می‌توانید Platform Channelها را تنظیم کنید
    // MethodChannel('app_communication').setMethodCallHandler(_handleMethodCall);
  }

  void _simulateCrossAppRequest(
    String requestId,
    String method,
    dynamic params,
  ) {
    // شبیه‌سازی پاسخ از اپ دیگر
    Future.delayed(const Duration(milliseconds: 500), () {
      // این فقط برای نمونه است
      final response = {'requestId': requestId, 'result': 'OK'};
      receiveFromOtherApp({'type': 'response', ...response});
    });
  }

  // ========== Cleanup ==========
  void dispose() {
    _notificationStream.close();

    for (final controller in _typedStreams.values) {
      controller.close();
    }
    _typedStreams.clear();

    for (final controller in _crossAppStreams.values) {
      controller.close();
    }
    _crossAppStreams.clear();

    _directListeners.clear();
    _typedListeners.clear();
    _notificationHistory.clear();
    _unconsumedNotifications.clear();

    for (final completer in _pendingRequests.values) {
      if (!completer.isCompleted) {
        completer.completeError('AppNotifier disposed');
      }
    }
    _pendingRequests.clear();
  }
}

// ========== Extension برای استفاده راحت‌تر ==========
extension AppNotifierExtensions on AppNotifier {
  // نوتیفیکیشن برای تغییرات entityهای خاص
  String notifyPersonDataChanged({dynamic payload}) {
    return notify(
      type: NotificationType.personDataChanged,
      message: 'داده‌های شخص تغییر کرد',
      payload: payload,
      source: 'PersonService',
      crossApp: true,
    );
  }

  String notifyLanguageChanged(String languageCode) {
    return notify(
      type: NotificationType.languageChanged,
      message: 'زبان تغییر کرد به $languageCode',
      payload: {'languageCode': languageCode},
      crossApp: true,
    );
  }

  String notifyGenericListRefresh(String listName) {
    return notify(
      type: NotificationType.genericListRefresh,
      message: 'لیست $listName نیاز به رفرش دارد',
      payload: {'listName': listName},
      crossApp: false,
    );
  }

  // درخواست از اپ دیگر
  Future<dynamic> requestDataFromParent(
    String endpoint,
    Map<String, dynamic> params,
  ) {
    return sendRequestToOtherApp(method: 'api/$endpoint', params: params);
  }

  Future<void> syncDataWithParent(Map<String, dynamic> data) async {
    await sendRequestToOtherApp(method: 'sync', params: data);
  }
}

// ========== Provider برای AppNotifier ==========
class AppNotifierProvider extends StatelessWidget {
  final Widget child;
  final AppNotifier notifier;

  const AppNotifierProvider({
    Key? key,
    required this.child,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AppNotifier>(create: (_) => notifier, child: child);
  }
}

// ========== Widget برای گوش دادن به نوتیفیکیشن‌ها ==========
class AppNotificationListener extends StatefulWidget {
  final Widget child;
  final NotificationListener? onNotification;
  final Map<NotificationType, NotificationListener>? typedListeners;
  final List<NotificationType>? listenToTypes;
  final bool listenToAll;

  const AppNotificationListener({
    Key? key,
    required this.child,
    this.onNotification,
    this.typedListeners,
    this.listenToTypes,
    this.listenToAll = false,
  }) : super(key: key);

  @override
  State<AppNotificationListener> createState() =>
      _AppNotificationListenerState();
}

class _AppNotificationListenerState extends State<AppNotificationListener> {
  late AppNotifier _notifier;
  StreamSubscription<AppNotification>? _subscription;
  final Map<String, String> _listenerKeys = {};

  void _setupListeners() {
    // ثبت listener مستقیم
    if (widget.onNotification != null) {
      final key = _notifier.addListener(widget.onNotification!);
      _listenerKeys['main'] = key;
    }

    // ثبت listenerهای تایپ‌دار
    if (widget.typedListeners != null) {
      for (final entry in widget.typedListeners!.entries) {
        _notifier.addTypedListener(entry.key, entry.value);
        _listenerKeys['typed_${entry.key.name}'] = entry.key.name;
      }
    }

    // ثبت از طریق Stream برای انواع خاص
    if (widget.listenToTypes != null && widget.listenToTypes!.isNotEmpty) {
      for (final type in widget.listenToTypes!) {
        final subscription = _notifier.typedStream(type).listen((notification) {
          _handleTypedNotification(type, notification);
        });
        // ذخیره subscription
        _subscription ??= subscription;
      }
    }

    // ثبت برای تمام نوتیفیکیشن‌ها
    if (widget.listenToAll) {
      _subscription = _notifier.notifications.listen((notification) {
        _handleNotification(notification);
      });
    }
  }

  void _handleNotification(AppNotification notification) {
    // منطق عمومی برای نمایش نوتیفیکیشن‌ها
    if (notification.priority.index >= NotificationPriority.high.index) {
      _showSnackbar(notification);
    }
  }

  void _handleTypedNotification(
    NotificationType type,
    AppNotification notification,
  ) {
    // پردازش نوع خاص
    switch (type) {
      case NotificationType.sessionExpired:
      case NotificationType.forceLogout:
        _handleSignOut(notification);
        break;
      case NotificationType.errorOccurred:
        _showErrorDialog(notification);
        break;
      case NotificationType.successMessage:
      default:
        _showSuccessSnackbar(notification);
        break;
    }
  }

  void _showSnackbar(AppNotification notification) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(notification.message ?? notification.type.toString()),
        backgroundColor: _getColorForPriority(notification.priority),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackbar(AppNotification notification) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(notification.message ?? 'عملیات موفق')),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorDialog(AppNotification notification) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(notification.title ?? 'خطا'),
        content: Text(notification.message ?? 'خطای نامشخص رخ داده است'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('باشه'),
          ),
        ],
      ),
    );
  }

  void _handleSignOut(AppNotification notification) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('خروج از سیستم'),
        content: const Text('سشن شما منقضی شده است. لطفاً مجدداً وارد شوید.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // هدایت به صفحه لاگین
              // Navigator.of(context).pushReplacementNamed('/login');
            },
            child: const Text('ورود مجدد'),
          ),
        ],
      ),
    );
  }

  Color _getColorForPriority(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.critical:
        return Colors.red;
      case NotificationPriority.urgent:
        return Colors.orange;
      case NotificationPriority.high:
        return Colors.amber;
      case NotificationPriority.normal:
        return Colors.blue;
      case NotificationPriority.low:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    // حذف listenerها
    for (final key in _listenerKeys.values) {
      if (key.startsWith('typed_')) {
        // برای typed listeners نیاز به logic خاص است
      } else if (key == 'main') {
        _notifier.removeListener(key);
      }
    }

    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// ========== Mixin برای استفاده راحت‌تر ==========
mixin AppNotifierMixin<T extends StatefulWidget> on State<T> {
  late AppNotifier _notifier;
  final List<String> _listenerKeys = [];
  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _notifier = AppNotifier._internal(); // استفاده از instance static
  }

  void addNotificationListener(NotificationListener listener, {String? key}) {
    final listenerKey = _notifier.addListener(listener, key: key);
    _listenerKeys.add(listenerKey);
  }

  void addTypedNotificationListener(
    NotificationType type,
    NotificationListener listener,
  ) {
    _notifier.addTypedListener(type, listener);
    _listenerKeys.add('typed_${type.name}');
  }

  void addNotificationSubscription(
    StreamSubscription<AppNotification> subscription,
  ) {
    _subscriptions.add(subscription);
  }

  String notifyApp({
    required NotificationType type,
    NotificationPriority priority = NotificationPriority.normal,
    String? title,
    String? message,
    dynamic payload,
    String? source,
    bool crossApp = false,
  }) {
    return _notifier.notify(
      type: type,
      priority: priority,
      title: title,
      message: message,
      payload: payload,
      source: source,
      crossApp: crossApp,
    );
  }

  Future<dynamic> sendToParentApp({
    required String method,
    dynamic params,
    Duration timeout = const Duration(seconds: 10),
  }) {
    return _notifier.sendRequestToOtherApp(
      method: method,
      params: params,
      timeout: timeout,
    );
  }

  @override
  void dispose() {
    // حذف تمام listenerها
    for (final key in _listenerKeys) {
      if (!key.startsWith('typed_')) {
        _notifier.removeListener(key);
      }
    }

    // لغو subscriptionها
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }
}

// ========== Global Helper Methods ==========
class AppNotificationHelper {
  static late final AppNotifier notifier;

  static String showSuccess(String message) {
    return notifier.notifySuccess(message);
  }

  static String showError(String message) {
    return notifier.notifyError(message);
  }

  static String showWarning(String message) {
    return notifier.notifyWarning(message);
  }

  static String showInfo(String message) {
    return notifier.notifyInfo(message);
  }

  static void forceLogout() {
    notifier.notifyForceLogout();
  }

  static Future<dynamic> callParentMethod(String method, dynamic params) {
    return notifier.sendRequestToOtherApp(method: method, params: params);
  }
}
