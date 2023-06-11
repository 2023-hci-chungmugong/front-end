import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/app_state.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class FirebaseManager {
  static Future<void> saveDataToFirestore(AppState appState) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      String documentId =
          appState.appDate.toIso8601String().split('T')[0]; // YYYY-MM-DD

      // ReservationForDate 컬렉션에 데이터 저장
      final Map<String, dynamic> reservationsData = {};
      appState.reservations.reservations
          .forEach((sectionName, sectionReservation) {
        final reservedList =
            sectionReservation.reserved.map((time) => time.toString()).toList();
        reservationsData[sectionName.toString()] = reservedList;
      });
      List<int> tmp = [];
      for (var i = appState.myReservations[0].start;
          i <= appState.myReservations[0].end;
          i++) {
        tmp.add(i);
      }

      reservationsData[appState.myReservations[0].section.toString()] = tmp;

      await firestore
          .collection('ReservationForDate')
          .doc(documentId) // 문서 ID로 날짜를 사용
          .set(reservationsData);

      // Avaliable 컬렉션에 데이터 저장
      final Map<String, dynamic> availData = {'time': appState.availableTime};
      await firestore.collection('available').doc(documentId).set(availData);

      // UserData 컬렉션에 데이터 저장
      final Map<String, dynamic> userData = {
        'id': appState.userData.id,
        'name': appState.userData.name,
        'abusing': [
          {
            'date': appState.abusingLog[0].date,
            'content': appState.abusingLog[0].type.toString(),
          }
        ],
        'section': [
          {
            'sectionName': appState.myReservations[0].section.toString(),
            'usingTime': [
              appState.myReservations[0].start,
              appState.myReservations[0].end
            ],
          }
        ]
      };
      await firestore
          .collection('user')
          .doc(appState.userData.id)
          .set(userData);
    } catch (e) {
      print('Error saving data to Firestore: $e');
    }
  }
}

// 데이터 확인
// ReservationForDate 컬렉션의 모든 문서 가져오기
Future<DocumentSnapshot> getTodayReservationForDate() async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('ReservationForDate').get();
  final List<DocumentSnapshot> documents = querySnapshot.docs;

  return documents[documents.length - 1];
}

Future<DocumentSnapshot> getTodayAvailable() async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('available').get();
  final List<DocumentSnapshot> documents = querySnapshot.docs;

  return documents[documents.length - 1];
}

// user 컬렉션의 모든 문서 가져오기
Future<DocumentSnapshot<Object?>> getUserData(String id) async {
  final DocumentSnapshot document =
      await FirebaseFirestore.instance.collection('user').doc(id).get();

  return document;
}

Future<void> addReservationForDate(
  SectionName sectionName,
  List<int> selected,
) async {
  AppState appState = AppState();
  String documentId = appState.appDate.toIso8601String().split('T')[0];

  final Map<String, dynamic> reservationData = {};
  reservationData[sectionName.toString()] = {
    ...selected,
    ...appState.reservations.reservations[sectionName]!.reserved
  };
  // print(sectionName.toString());
  // print(appState.reservations.reservations[SectionName.na]!.reserved);
  // print(reservationData);
  await firestore
      .collection('ReservationForDate')
      .doc(documentId)
      .update(reservationData);
}

Future<void> addUserReservation(
  SectionName sectionName,
  List<int> selected,
) async {
  AppState appState = AppState();
  String documentId = appState.userData.id.toString();

  Map<String, dynamic> reservation = {
    'reservations': FieldValue.arrayUnion([
      {
        'sectionName': sectionName.toString(),
        'startTime': selected[0],
        'endTime': selected[selected.length - 1],
        'status': ReservationStatus.reserved.toString(),
      }
    ])
  };

  await firestore.collection('user').doc(documentId).update(reservation);
}

Future<void> removeUserReservation(int idx) async {
  AppState appState = AppState();
  String documentId = appState.userData.id.toString();

  DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await firestore.collection('user').doc(documentId).get();
  Map<String, dynamic>? firebase_reservation = documentSnapshot.data();

  dynamic remove_reservation =
      (firebase_reservation!['reservations'] as List<dynamic>)[idx];
  (firebase_reservation['reservations'] as List<dynamic>).removeAt(idx);

  await firestore
      .collection('user')
      .doc(documentId)
      .update(firebase_reservation);

  final Map<String, dynamic> reservationData = {};

  List<int> target = [];
  for (int i = remove_reservation['startTime'];
      i <= remove_reservation['endTime'];
      i++) {
    target.add(i);
  }

  reservationData[remove_reservation['sectionName']] = appState
      .reservations
      .reservations[stringToSectionName(remove_reservation['sectionName'])]!
      .reserved
      .where((e) => !target.contains(e))
      .toList();

  // print("sfsf");
  // print(reservationData);
  // print("sfsf");

  documentId = appState.appDate.toIso8601String().split('T')[0];

  await firestore
      .collection('ReservationForDate')
      .doc(documentId)
      .update(reservationData);
}
