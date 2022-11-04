import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:events_app/core/utils/app_keys.dart';

class EventModel extends Equatable {
  final String eventId;
  final String eventName;
  final String eventDescription;
  final int eventColorHex;
  final String eventLocation;
  final DateTime eventDate;
  final String timeFrom;
  final String timeTo;

  const EventModel({
    required this.eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventColorHex,
    required this.eventLocation,
    required this.eventDate,
    required this.timeFrom,
    required this.timeTo,
  });

  @override
  List<Object?> get props => [
        eventColorHex,
        eventDescription,
        eventLocation,
        eventName,
        timeFrom,
        timeTo,
        eventId,
        eventDate,
      ];

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
