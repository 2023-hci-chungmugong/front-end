import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/view/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  AppState().saveDataToFirestore();
  AppState().check();

  var logger = Logger();
  print("main 입니다.");
  logger.d("Logger is working!");
}

class MyApp extends StatelessWidget {
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
