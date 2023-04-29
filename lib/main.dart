import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
