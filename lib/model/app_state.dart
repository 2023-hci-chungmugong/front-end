import 'package:chungmugong_front_end/model/abusing.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  // 5~9라인 써주면 인스턴스가 Sigletone으로 생성됨
  static final AppState _instance = AppState._internal();

  factory AppState() => _instance;
  AppState._internal();

  // 아래에 모델(전역변수) 추가
  DateTime appDate = DateTime.now();

  // 아래 변수는 추후 Firebase와 연결하여 초기화 되어야함
  ReservationForDate reservations = ReservationForDate(DateTime.now());
  List<Abusing> abusingLog = [];
  List<ReservationForUser> myReservations = [];
}
