import 'dart:convert';

import '../../../../core/utils/app_keys.dart';
import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    required String eventId,
    required String eventName,
    required String eventDescription,
    required int eventColorHex,
    required String eventLocation,
    required DateTime eventDate,
    required String timeFrom,
    required String timeTo,
  }) : super(
          eventId: eventId,
          eventColorHex: eventColorHex,
          eventDate: eventDate,
          eventDescription: eventDescription,
          eventLocation: eventLocation,
          eventName: eventName,
          timeFrom: timeFrom,
          timeTo: timeTo,
        );

  Map<String, dynamic> toMap() {
    return {
      AppKeys.eventId: eventId,
      AppKeys.eventName: eventName,
      AppKeys.eventDescription: eventDescription,
      AppKeys.eventColorHex: eventColorHex,
      AppKeys.eventLocation: eventLocation,
      AppKeys.timeFrom: timeFrom,
      AppKeys.timeTo: timeTo,
      AppKeys.eventDate: eventDate.toIso8601String(),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventId: map[AppKeys.eventId] ?? '',
      eventName: map[AppKeys.eventName] ?? '',
      eventDescription: map[AppKeys.eventDescription] ?? '',
      eventColorHex: map[AppKeys.eventColorHex]?.toInt() ?? 0,
      eventLocation: map[AppKeys.eventLocation] ?? '',
      timeFrom: map[AppKeys.timeFrom] ?? '',
      timeTo: map[AppKeys.timeTo] ?? '',
      eventDate: DateTime.parse(map[AppKeys.eventDate] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));
}
