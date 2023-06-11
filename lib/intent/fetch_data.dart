import 'package:chungmugong_front_end/firebase/firebase_firestore.dart';
import 'package:chungmugong_front_end/model/abusing.dart';
import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/model/profile.dart';
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

  static Future<void> updateUserData(String id) async {
    AppState appState = AppState();

    DocumentSnapshot userData = await getUserData(id);

    // print("sDF");
    Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
    List<dynamic> abusing = data['abusing'];
    for (var ab in abusing) {
      int microTime = (ab['date'] as Timestamp).microsecondsSinceEpoch;
      AbusingType abType =  stringToAbusingType(ab['content']);
        appState.abusingLog.add(Abusing(
            DateTime.fromMicrosecondsSinceEpoch(microTime),
           abType));
      print(stringToAbusingType(ab['content']).runtimeType);
    }
    print(appState.abusingLog);

    // print(appState.abusingLog[0].date);

    appState.userData = Profile(data['name'], data['id']);

    // print(appState.userData.name);

    List<dynamic> reservations = data['reservations'];
    for (var reservation in reservations) {
      appState.myReservations.add(ReservationForUser(
        date: DateTime.now(),
        section: stringToSectionName(reservation['sectionName'])!,
        start: reservation['startTime'],
        end: reservation['endTime'],
        status: stringToReservationStatus(reservation['status'])!,
      ));
    }

    // print(appState.myReservations[0].end);
  }

  // static void updateAppData() {
  //   getTodayReservationForDate();
  //   getUserData();
  // }
}
