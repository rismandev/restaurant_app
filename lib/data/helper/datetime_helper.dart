/*  Datetime Helper
    Handle Format Date & Time
    [format] => Format Date & Time Local
    Set Time to 11 AM for schedule notification
    [getDate] => Get format Date (Ex. 2020-11-21)

    Date Created                      Date Updated
    21 November 2020                  21 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

class DateTimeHelper {
  static DateTime format() {
    DateTime date = DateTime.now().toLocal();
    String resultToday = getDate(fullDateTime: date) + " 11:00:00.000";

    DateTime dateTomorrow = date.add(Duration(days: 1));
    String resultTomorrow =
        getDate(fullDateTime: dateTomorrow) + " 11:00:00.000";

    if (date.hour > 10 && date.minute > 59) {
      return DateTime.parse(resultTomorrow).toUtc();
    }
    return DateTime.parse(resultToday).toLocal();
  }

  static String getDate({DateTime fullDateTime}) {
    String month = fullDateTime.month.toString();
    String day = fullDateTime.day.toString();
    String _month;
    String _day;
    if (month.length == 2) {
      _month = month;
    } else {
      _month = "0$month";
    }
    if (day.length == 2) {
      _day = day;
    } else {
      _day = "0$day";
    }

    String result = "${fullDateTime.year}-$_month-$_day";
    return result;
  }
}
