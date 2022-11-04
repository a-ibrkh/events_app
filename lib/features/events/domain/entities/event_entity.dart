import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String eventId;
  final String eventName;
  final String eventDescription;
  final int eventColorHex;
  final String eventLocation;
  final DateTime eventDate;
  final String timeFrom;
  final String timeTo;

  const EventEntity({
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
}
