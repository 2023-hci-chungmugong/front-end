// 자리 이름을 enum으로 나열
enum SectionName { ga, na, da, ra, ma }

// '가', '나'와 같은 자리명을 enum으로 변환
SectionName? stringToSectionName(String value) {
  if (value == '가') {
    return SectionName.ga;
  } else if (value == '나') {
    return SectionName.na;
  } else if (value == '다') {
    return SectionName.da;
  } else if (value == '라') {
    return SectionName.ra;
  } else if (value == '마') {
    return SectionName.ma;
  }

  return null;
}

// SectionName을 String으로 변환
String sectionNameToString(SectionName value) {
  if (value == SectionName.ga) {
    return "가";
  } else if (value == SectionName.na) {
    return "나";
  } else if (value == SectionName.da) {
    return "다";
  } else if (value == SectionName.ra) {
    return "라";
  } else {
    return "마";
  }
}

// 자리 하나의 예약을 관리하는 클래스
class SectionReservation {
  final List<int> avaliable;
  final List<int> reserved = [];

  SectionReservation(this.avaliable);

  static const List<int> defaultAvaliable = [
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17
  ];
  static const List<int> testPeriodAvaliable = [
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21
  ];

  // 1시간 단위 예약에 사용하는 함수
  bool reserve(int time) {
    if (avaliable.contains(time)) {
      if (!reserved.contains(time)) {
        reserved.add(time);
        return true;
      }
    }

    return false;
  }

  // 2시간 이상 예약에 사용하는 함수
  bool reserveDuration(int start, int end) {
    List<int> tmp = [];

    for (int i = start; i <= end; i++) {
      if (avaliable.contains(i)) {
        if (!reserved.contains(i)) {
          tmp.add(i);
          continue;
        }
      }
      return false;
    }

    reserved.addAll(tmp);
    return true;
  }
}

// 하루의 예약을 관리하는 클래스
class ReservationForDate {
  final DateTime date;
  late Map<SectionName, SectionReservation> reservations;

  ReservationForDate(this.date) {
    reservations = {
      SectionName.ga: SectionReservation(SectionReservation.defaultAvaliable),
      SectionName.na: SectionReservation(SectionReservation.defaultAvaliable),
      SectionName.da: SectionReservation(SectionReservation.defaultAvaliable),
      SectionName.ra: SectionReservation(SectionReservation.defaultAvaliable),
      SectionName.ma: SectionReservation(SectionReservation.defaultAvaliable),
    };
  }
  ReservationForDate.testPeriod(this.date) {
    reservations = {
      SectionName.ga:
          SectionReservation(SectionReservation.testPeriodAvaliable),
      SectionName.na:
          SectionReservation(SectionReservation.testPeriodAvaliable),
      SectionName.da:
          SectionReservation(SectionReservation.testPeriodAvaliable),
      SectionName.ra:
          SectionReservation(SectionReservation.testPeriodAvaliable),
      SectionName.ma:
          SectionReservation(SectionReservation.testPeriodAvaliable),
    };
  }
}

// 예약의 상태 enum으로 나열
enum ReservationStatus { reserved, canceled, using, end }

// 유저의 예약 정보를 관리하는 클래스
class ReservationForUser {
  final DateTime date;
  final SectionName section;
  final int start;
  final int end;
  ReservationStatus status;

  ReservationForUser(
      {required this.date,
      required this.section,
      required this.start,
      required this.end,
      required this.status});

  String durationToString() {
    String str = "";

    if (start < 10) {
      str = "0${start.toString()}";
    } else {
      str = start.toString();
    }
    str += ":00 ~ ";

    if (end < 9) {
      str += "0${(end + 1).toString()}";
    } else {
      str += (end + 1).toString();
    }
    str += ":00";

    return str;
  }
}
