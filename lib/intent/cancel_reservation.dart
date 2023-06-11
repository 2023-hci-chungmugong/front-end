import 'package:chungmugong_front_end/model/app_state.dart';

void cancelReservation(int idx) {
  AppState appState = AppState();
  appState.myReservations.removeAt(idx);
  appState.notifyListeners();
}