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
Future<List<DocumentSnapshot>> fetchUserData() async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('user').get();
  final List<DocumentSnapshot> documents = querySnapshot.docs;

  return documents;
}
