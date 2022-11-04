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
}
