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
    await updateReservationForDate(sectionName, clicked);
    await updateUserReservation(sectionName, clicked);

    await FetchAppData.initializeAppData();
    await FetchAppData.updateUserData(appState.userData.id);

    print(appState.reservations.reservations[SectionName.na]!.reserved);
  }
}
