import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static final LocalNotification _instance = LocalNotification._internal();
  static final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  factory LocalNotification() => _instance;
  LocalNotification._internal();

  static initialize() async {
    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const DarwinInitializationSettings initSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
      macOS: initSettingsIOS,
    );

    await _localNotification.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // ?
      },
      // onDidReceiveBackgroundNotificationResponse: (details) => print('bad,,'),
    );
  }

  static void requestPermission() {
    _localNotification
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  static Future<void> testNotification() async {
    const AndroidNotificationDetails android =
        AndroidNotificationDetails('channelId', 'Name');
    const NotificationDetails notiDetails = NotificationDetails(
        android: android, iOS: DarwinNotificationDetails(badgeNumber: 1));

    await _localNotification.show(
      0,
      '충무공 - 충남대무한상상공간 예약서비스',
      '예약 시간이 임박하였습니다. 입장을 완료해주세요.',
      notiDetails,
    );
  }

  static Future<void> testSchedule() async {
    const AndroidNotificationDetails android =
        AndroidNotificationDetails('channelId', 'Name');
    const NotificationDetails notiDetails = NotificationDetails(
        android: android, iOS: DarwinNotificationDetails(badgeNumber: 1));
    await _localNotification.zonedSchedule(
      1,
      'Schedule!',
      'EZ',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      notiDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  // static Future<void> setNotification(DateTime time) async {
  //   const AndroidNotificationDetails android =
  //       AndroidNotificationDetails('channelId', 'Name');
  //   const NotificationDetails notiDetails = NotificationDetails(
  //     android: android,
  //     iOS: DarwinNotificationDetails(badgeNumber: 1),
  //   );
  //   await _localNotification.zonedSchedule(
  //     0,
  //     'MusicVideos',
  //     'hey!',
  //     tz.TZDateTime.from(time, tz.local),
  //     notiDetails,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }
}
