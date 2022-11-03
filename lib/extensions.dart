import 'package:intl/intl.dart';

extension DayDateTime on DateTime {
  DateTime toDay() => DateTime(year, month, day);

  String get dayLetter {
    final formatter = DateFormat.E();

    return formatter.format(this)[0];
  }
}
