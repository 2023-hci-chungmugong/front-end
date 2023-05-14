import 'dart:async';

import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/view/lobby_body.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final NetworkInfo networkInfo = NetworkInfo();
  late StreamSubscription<ConnectivityResult> subscription;
  BuildContext context;

  NotificationManager(this.context) {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('assets/images/login_logo.png');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  Future<void> showNotification(String title, String message) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_name', 'channel_description',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, message, platformChannelSpecifics,
        payload: 'Default_Sound');
  }

  void handleConnectivityChanged(ConnectivityResult connectivityResult) {
    final String iPAddress = '10.0.2.16';
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      final wifiName = await networkInfo.getWifiName();
      if (result == ConnectivityResult.wifi && wifiName == iPAddress) {
        showNotification('연결', '연결되었습니다.');
      }
    });

  

}
    // if (connectivityResult == ConnectivityResult.wifi) {
    //   // 현재 연결된 와이파이 정보를 가져옴
    //   Connectivity().getWifiName().then((wifiname) {
    //     // 지정한 IP 주소를 가지고 있는 와이파이인지 확인
    //     if (wifiName == 'YOUR_IP_ADDRESS_WIFI_NAME') {
    //       // 알림을 띄움
    //       showNotification('Wifi Connected',
    //           'You are connected to your designated Wifi network!');
    //     }
    //   });
    // }
  }
}
