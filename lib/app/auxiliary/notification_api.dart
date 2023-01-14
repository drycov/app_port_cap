import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final NotificationApi _notificationApi = NotificationApi._internal();

  static final _notifications = FlutterLocalNotificationsPlugin();
  factory NotificationApi() {
    return _notificationApi;
  }
  NotificationApi._internal();

  Future<void> init({bool initScheduled = false}) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        // ignore: prefer_const_constructors
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    await _notifications.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones();
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
      ),
    );
  }

  static void showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
  static Future showNotification({
    int id = 0,
    required String title,
    required String body,
    required String payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);
  void cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  void cancelAllNotification() async {
    await _notifications.cancelAll();
  }
}
