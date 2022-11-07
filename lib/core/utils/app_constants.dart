import 'package:events_app/core/utils/app_keys.dart';

class AppConstants {
  AppConstants._();

  static const sqlStringType = "TEXT NOT NULL";
  static const sqlIntType = "INTEGER NOT NULL";
  static const sqlEventColumns = [
    AppKeys.eventId,
    AppKeys.eventName,
    AppKeys.eventDescription,
    AppKeys.eventColorHex,
    AppKeys.eventLocation,
    AppKeys.eventDate,
    AppKeys.timeFrom,
    AppKeys.timeTo,
  ];

  static const weekdaysShort = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  static const weekdaysFull = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  static const monthsName = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  static const paginationLimit = 5;
}
