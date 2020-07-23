import 'package:shared_preferences/shared_preferences.dart';

clearLog() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('token', '');
}

processDateTimeAsDate(DateTime date) {
  String day;
  String month;

  if (date.day < 10) {
    day = '0' + date.day.toString();
  } else {
    day = date.day.toString();
  }

  if (date.month < 10) {
    month = '0' + date.month.toString();
  } else {
    month = date.month.toString();
  }

  return day + '-' + month + '-' + date.year.toString();
}
