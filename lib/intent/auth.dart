import 'package:chungmugong_front_end/firebase/firebase_firestore.dart';
import 'package:chungmugong_front_end/intent/fetch_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  static Future<bool> auth(String id, String pw) async {
    // ID와 PW는 같음
    if (id == pw && id[0] == '2' && id[1] == '0') {
      DocumentSnapshot<Object?> userData = await getUserData(id);
      if (userData.data() != null) {
        await FetchAppData.updateUserData(id);
        return true;
      }
    }
    return false;
  }
}
