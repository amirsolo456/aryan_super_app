import 'dart:async';

import 'storage_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final StorageService storage;
  final Duration refreshInterval;
  Timer? _tokenRefreshTimer;
  bool _isRefreshing = false;

  NotificationService({
    required this.storage,
    this.refreshInterval = const Duration(minutes: 30),
  }) {
    _tokenRefreshTimer = Timer.periodic(refreshInterval, (_) => _onTimerTick());
    _onTimerTick();
  }

  Future<void> _onTimerTick() async {
    if (_isRefreshing) return;
    _isRefreshing = true;

    try {
      await _refreshToken();
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _refreshToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null && token.isNotEmpty) {
        print('Token refreshed: $token');
        await storage.setDeviceToken(token);
        // می‌توانی اینجا توکن رو به سرور بفرستی
      }
    } catch (e) {
      print('Error refreshing token: $e');
    }
  }

  /// گرفتن توکن با محدودیت زمان
  Future<String> getTokenWithTimeout({int timeoutSeconds = 20}) async {
    try {
      final token = await FirebaseMessaging.instance.getToken().timeout(
        Duration(seconds: timeoutSeconds),
      );
      return token ?? '';
    } on TimeoutException {
      print('⚠️ Token request timed out!');
      return '';
    } catch (e) {
      print('❌ Error getting token: $e');
      return '';
    }
  }

  Future<String> getToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      return token ?? '';
    } catch (_) {
      return '';
    }
  }

  /// شبیه‌سازی ارسال نوتیفیکیشن
  Future<void> sendNotification(String title, String text) async {
    final token = await getToken();
    print('SendNotification: $title - $text (Token: $token)');
    // اینجا می‌توانی درخواست به سرور بفرستی
  }

  /// Dispose کردن تایمر
  void dispose() {
    _tokenRefreshTimer?.cancel();
  }
}
