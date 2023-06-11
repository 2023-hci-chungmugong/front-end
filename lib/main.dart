import 'package:chungmugong_front_end/intent/fetch_data.dart';
import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/view/login_view.dart';
import 'package:chungmugong_front_end/view/wifi_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';

void main() async {
  var logger = Logger();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  FetchAppData.initializeAppData();
  FetchAppData.updateUserData('201802163');

  logger.d("Logger is working!");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: '충무공',
        theme: ThemeData(
          colorSchemeSeed: Color.fromARGB(255, 17, 22, 160),
        ),
        home: LoginView(),
      ),
    );
  }
}
