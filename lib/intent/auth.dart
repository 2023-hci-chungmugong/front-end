class Auth {
  static bool auth(String id, String pw) {
    // TODO: 포털 로그인시스템 연동하기
    // 학번과 비번은 현재 1111임.
    if (id == '1111' && pw == '1111') return true;
    return false;
  }
}
