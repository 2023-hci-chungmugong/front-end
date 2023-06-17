import 'package:chungmugong_front_end/firebase/firebase_firestore.dart';
import 'package:chungmugong_front_end/intent/fetch_data.dart';
import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/view/lobby_view.dart';
import 'package:chungmugong_front_end/view/wifi_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> entryReservation() async {
  AppState appState = AppState();
  String documentId = appState.userData.id.toString();
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await firestore.collection('user').doc(documentId).get();
  Map<String, dynamic>? data = documentSnapshot.data();
  List<dynamic>? reservations = data!['reservations'] as List<dynamic>?;

  if (data != null) {
    int nearest = appState.nearestTime;
    int idx = 0;
    logger.d('nearest Time : $nearest');
    for (int i = 0; i < appState.myReservations.length; i++) {
      if (appState.myReservations[i].start == nearest) {
        idx = i;
      }
    }

    Map<String, dynamic> mapping = reservations![idx] as Map<String, dynamic>;
    mapping['status'] = ReservationStatus.using.toString();
    reservations![idx] = mapping;
  }
  //status만 업데이트
  await firestore
      .collection('user')
      .doc(documentId)
      .update({'reservations': reservations});
}
