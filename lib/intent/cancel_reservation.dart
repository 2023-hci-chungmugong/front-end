import 'package:chungmugong_front_end/firebase/firebase_firestore.dart';
import 'package:chungmugong_front_end/intent/fetch_data.dart';
import 'package:chungmugong_front_end/model/app_state.dart';

Future<void> cancelReservation(int idx) async {
  AppState appState = AppState();
  appState.myReservations.removeAt(idx);
  await removeUserReservation(idx);

  await FetchAppData.initializeAppData();
  await FetchAppData.updateUserData(appState.userData.id);

  appState.notifyListeners();
}
