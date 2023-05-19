enum AbusingType { noshow, leave }

String? getAbusingMessage(AbusingType type) {
  if (type == AbusingType.noshow) {
    return "예약 후 입장하지 않음";
  } else if (type == AbusingType.leave) {
    return "무한상상공간에서 오래 벗어남";
  }
  return null;
}

// 부정 이용 기록 관리 클래스
class Abusing {
  final DateTime date;
  final AbusingType type;

  Abusing(this.date, this.type);
}
