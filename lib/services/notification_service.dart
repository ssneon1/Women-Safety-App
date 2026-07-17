import 'package:flutter/foundation.dart';


class NotificationService {
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    if (kDebugMode) {
      debugPrint('[NotificationService] Initialized.');
    }
  }

  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    // In a production app this would call your backend to send FCM push.
    // For now, just log it.
    if (kDebugMode) {
      debugPrint('[NotificationService] Sending to $token: $title - $body');
    }
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (kDebugMode) {
      debugPrint('[NotificationService] Local notification #$id: $title - $body');
    }
  }
}
