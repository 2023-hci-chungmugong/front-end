String dateTimeToString(DateTime dt) {
  return "${dt.year}년 ${dt.month}월 ${dt.day}일 (${weekDayToString(dt.weekday)})";
}
String weekDayToString(int wd) {
  switch(wd) {
    case 1:
      return "월";
    case 2:
      return "화";
    case 3:
      return "수";
    case 4:
      return "목";
    case 5:
      return "금";
    case 6:
      return "토";
    case 7:
      return "일";
    default:
      return "먼날짜고";
  }
}
