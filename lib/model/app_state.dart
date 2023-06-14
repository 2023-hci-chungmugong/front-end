import 'package:chungmugong_front_end/model/abusing.dart';
import 'package:chungmugong_front_end/model/profile.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_firestore.dart';

class AppState extends ChangeNotifier {
  // 7~10라인 써주면 인스턴스가 Sigletone으로 생성됨
  static final AppState _instance = AppState._internal();

  factory AppState() => _instance;
  AppState._internal();

  // 아래에 모델(전역변수) 추가
  DateTime appDate = DateTime.now();
  int nearestTime = 0;
  int currentHour = DateTime.now().hour;

  // 아래 변수는 추후 Firebase와 연결하여 초기화 되어야함
  ReservationForDate reservations = ReservationForDate(DateTime.now());
  List<int> availableTime = SectionReservation.defaultavailable;
  List<Abusing> abusingLog = [];
  List<ReservationForUser> myReservations = [];
  Profile userData = Profile('None', '200000000');
}
