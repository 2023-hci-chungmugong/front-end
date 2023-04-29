import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();

  factory AppState() => _instance;
  AppState._internal();

  // 여기에 모델(전역변수) 추가
}
