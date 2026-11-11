enum WeekdayOptions {

  shorthand,
  longhand,
}

String getWeekDay(int weekdayIndex, { WeekdayOptions weekdayOption = .shorthand }) {

  String result = "";

  switch (weekdayIndex) {
    case 0:
      result = "Sunday";
    case 1:
      result = "Monday";
    case 2:
      result = "Tuesday";
    case 3:
      result = "Wednesday";
    case 4:
      result = "Thursday";
    case 5:
      result = "Friday";
    case 6:
      result = "Saturday";
    default:
      throw FormatException("Invalid weekday index");
  }

  if (weekdayOption == .shorthand) {
    result = result.substring(0, 3);
  }
  return result;
}