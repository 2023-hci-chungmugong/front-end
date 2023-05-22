import 'dart:async';

import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/view/wifi_modal.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

class WifiIn extends StatefulWidget {
  final Widget child;

  const WifiIn({Key? key, required this.child}) : super(key: key);

  @override
  _WifiIn createState() => _WifiIn();
}

class _WifiIn extends State<WifiIn> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static const String CMGWifiIP = '10.0.2.16';
  // static const String CMGWifiBSSID = 'AndroidWifi';

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        _connectCMGWIFI();
      }
    });
  }

  void _connectCMGWIFI() async {
    final info = NetworkInfo();
    final wifiname = await info.getWifiBSSID(); // "AndroidWifi"
    final wifiIP = await info.getWifiIP();
    if (wifiIP == CMGWifiIP) {
      showDialog<void>(
          context: context,
          builder: (context) {
            return WifiModal();
          });
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          child: widget.child,
        );
      },
    );
  }
}
