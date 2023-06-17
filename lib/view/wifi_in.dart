import 'dart:async';
import 'package:chungmugong_front_end/intent/local_notification.dart';
import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/view/wifi_modal.dart';
import 'package:flutter/material.dart';
// import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

import 'package:logger/logger.dart';

var logger = Logger();
int currentHour = DateTime.now().hour;
int cnt = 0;

class WifiIn extends StatefulWidget {
  final Widget child;

  const WifiIn({Key? key, required this.child}) : super(key: key);

  @override
  State<WifiIn> createState() => _WifiIn();
}

class _WifiIn extends State<WifiIn> with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // static const String CMGWifiIP = '10.0.2.16';
  // static const String CMGWifiBSSID = 'AndroidWifi';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _start();
  }

  // void _connectCMGWIFI() async {
  //   final info = NetworkInfo();
  //   final wifiname = await info.getWifiBSSID(); // "AndroidWifi"
  //   final wifiIP = await info.getWifiIP();

  //   if (wifiIP == CMGWifiIP) {
  //     showDialog<void>(
  //         context: context,
  //         builder: (context) {
  //           return WifiModal();
  //         });
  //   }
  // }

  @override
  void dispose() {
    _timer.cancel();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _start() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // 시간 모니터링, 5초마다

      currentHour = DateTime.now().hour;
      // 로그아웃 할 때까지 못 멈춤,,
    });
  }

  @override
  Widget build(BuildContext context) {
    // LocalNotification.testNotification();

    return Builder(
      builder: (BuildContext context) {
        int idx = 0;
        var appState = context.watch<AppState>();
        for (int i = 0; i < appState.myReservations.length; i++) {
          if (currentHour <= appState.myReservations[i].start) {
            appState.nearestTime = appState.myReservations[i].start;
            idx = i; //가장 가까운 예약 시간
            break;
          }
        }
        //가까운 start 시간에 reserved인 경우
        // print(appState.nearestTime);
        if ((appState.myReservations.isNotEmpty) &&
            (appState.nearestTime == currentHour) &&
            (appState.myReservations[idx].status ==
                ReservationStatus.reserved)) {
          //가장 가까운 예약 start가 지금 시간이 됐으면 푸시
          // print("!@@#!#!@");
          _connectivitySubscription = _connectivity.onConnectivityChanged
              .listen((ConnectivityResult result) {
            int tmp = appState.myReservations.length;
            if (tmp != 0) {
              LocalNotification.testNotification();
              showDialog<void>(
                  context: context,
                  builder: (context) {
                    return WifiModal(idx: idx);
                  });
            } // 시간 되면 와이파이 감지 시작
          });

          //지금 예약된 시간 내에서 using인 경우
        } else if ((appState.myReservations.isNotEmpty) &&
            (currentHour >= appState.myReservations[idx].start) &&
            (currentHour < appState.myReservations[idx].end) &&
            appState.myReservations[idx].status == ReservationStatus.using) {
          _connectivitySubscription = _connectivity.onConnectivityChanged
              .listen((ConnectivityResult result) async {
            // final info = NetworkInfo();
            // final wifiIP = await info.getWifiIP();
            //지정한 와이파이랑 연결이 다름
            if (result == ConnectivityResult.mobile) {
              //여기에 푸시알림
              // print('hi');
              LocalNotification.testNotification();
            }
          });
        }
        return Container(
          child: widget.child,
        );
      },
    );
  }
}
