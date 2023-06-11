import 'package:chungmugong_front_end/firebase/firebase_firestore.dart';
import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchAppData {
  static Future<void> initializeAppData() async {
    AppState appState = AppState();

    DocumentSnapshot available = await getTodayAvailable();
    DocumentSnapshot reservationForDate = await getTodayReservationForDate();

    // print(reservationForDate.data());

    Map<String, dynamic> data = available.data() as Map<String, dynamic>;
    List<dynamic> notParsed = data['time'];
    appState.availableTime =
        notParsed.map((e) => int.parse(e.toString())).toList();

    Map<String, dynamic> firebaseReservations =
        reservationForDate.data() as Map<String, dynamic>;
    appState.reservations.reservations[SectionName.ga]!.reserved.addAll(
        (firebaseReservations["SectionName.ga"] as List<dynamic>)
            .map((e) => int.parse(e.toString())));
    appState.reservations.reservations[SectionName.na]!.reserved.addAll(
        (firebaseReservations["SectionName.na"] as List<dynamic>)
            .map((e) => int.parse(e.toString())));
    appState.reservations.reservations[SectionName.da]!.reserved.addAll(
        (firebaseReservations["SectionName.da"] as List<dynamic>)
            .map((e) => int.parse(e.toString())));
    appState.reservations.reservations[SectionName.ra]!.reserved.addAll(
        (firebaseReservations["SectionName.ra"] as List<dynamic>)
            .map((e) => int.parse(e.toString())));
    appState.reservations.reservations[SectionName.ma]!.reserved.addAll(
        (firebaseReservations["SectionName.ma"] as List<dynamic>)
            .map((e) => int.parse(e.toString())));

    // print(appState.reservations.reservations[SectionName.na]!.reserved);
  }

  static void updateAppData() {
    getTodayReservationForDate();
    fetchUserData();
  }
}
