import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';
import '../model/app_state.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class FirebaseManager {
  static Future<void> saveDataToFirestore(AppState appState) async {
    try {
      print("firebase start");
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // ReservationForDate 컬렉션에 데이터 저장
      final Map<String, dynamic> reservationsData = {};
      appState.reservations.reservations
          .forEach((sectionName, sectionReservation) {
        final reservedList =
            sectionReservation.reserved.map((time) => time.toString()).toList();
        reservationsData[sectionName.toString()] = reservedList;
      });
      String documentId =
          appState.appDate.toIso8601String().split('T')[0]; // YYYY-MM-DD
      await firestore
          .collection('ReservationForDate')
          .doc(documentId) // 문서 ID로 날짜를 사용
          .set(reservationsData);

      // UserData 컬렉션에 데이터 저장
      final Map<String, dynamic> userData = {
        'name': appState.userData.name,
        'id': appState.userData.id,
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

// ReservationForDate 컬렉션의 모든 문서 가져오기
void fetchReservationForDate() async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('ReservationForDate').get();
  final List<DocumentSnapshot> documents = querySnapshot.docs;

  for (DocumentSnapshot document in documents) {
    print('Document ID: ${document.id}');
    print('Data: ${document.data()}');
  }
}

// user 컬렉션의 모든 문서 가져오기
void fetchUserData() async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('user').get();
  final List<DocumentSnapshot> documents = querySnapshot.docs;

  for (DocumentSnapshot document in documents) {
    print('Document ID: ${document.id}');
    print('Data: ${document.data()}');
  }
}
