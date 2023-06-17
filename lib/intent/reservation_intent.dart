import 'package:chungmugong_front_end/firebase/firebase_firestore.dart';
import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/intent/fetch_data.dart';

Future<void> makeReservation(SectionName sectionName, List<int> clicked) async {
  AppState appState = AppState();

  List<int> intersection = appState
      .reservations.reservations[sectionName]!.reserved
      .where((element) => clicked.contains(element))
      .toList();

  if (intersection.isEmpty) {
    await addReservationForDate(sectionName, clicked);
    await addUserReservation(sectionName, clicked);

    await FetchAppData.initializeAppData();
    await FetchAppData.updateUserData(appState.userData.id);

    appState.myReservations.sort((a, b) => a.start.compareTo(b.start));

    forceUpdateUserReservation();

    appState.notifyListeners();

    // print(appState.reservations.reservations[SectionName.na]!.reserved);
  }
}
