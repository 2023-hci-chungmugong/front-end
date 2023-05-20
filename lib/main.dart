import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/view/login_view.dart';
import 'package:chungmugong_front_end/view/wifi_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WifiIn _wifiIn;

  MyApp({Key? key})
      : _wifiIn = WifiIn(child: LoginView()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: '충무공',
        theme: ThemeData(
          colorSchemeSeed: Color.fromARGB(255, 17, 22, 160),
        ),
        home: _wifiIn,
      ),
    );
  }
}
