import 'dart:async';

import 'package:chungmugong_front_end/model/app_state.dart';
// import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/view/lobby_body.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

// import 'package:wifi_flutter/wifi_flutter.dart';

// class WifiIn extends StatelessWidget {
//   const WifiIn({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Alert Dialog'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: null,
//           child: Text('Button'),
//         ),
//       ),
//     );
//   }
// }

class WifiIn extends StatefulWidget {
  final Widget child;

  const WifiIn({Key? key, required this.child}) : super(key: key);

  @override
  _WifiIn createState() => _WifiIn();
}

class _WifiIn extends State<WifiIn> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        _showWifiAlertDialog();
      }
    });
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

  void _showWifiAlertDialog() async {
    final info = NetworkInfo();
    // final wifiname = await info.getWifiName(); // "AndroidWifi"
    final wifiIP = await info.getWifiIP(); // "10.0.2.16"
    if (wifiIP == '10.0.2.16') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            var appState = context.watch<AppState>();
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: Column(
                children: <Widget>[
                  new Text("Wifi In"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "입장하시겠습니까?",
                  ),
                ],
              ),
              actions: <Widget>[
                new TextButton(
                  child: new Text("입장"),
                  onPressed: () {
                    appState.notifyListeners();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }
}
