import 'dart:convert';

import 'package:events_app/features/events/data/models/event_model.dart';
import 'package:events_app/features/events/domain/entities/event_entity.dart';

//@Injectable(as: Converter<EventModel, EventEntity>)
class EventConverter extends Converter<EventModel, EventEntity> {
  @override
  EventEntity convert(EventModel input) {
    return EventEntity(
        eventId: input.eventId,
        eventName: input.eventName,
        eventDescription: input.eventDescription,
        eventColorHex: input.eventColorHex,
        eventLocation: input.eventLocation,
        eventDate: input.eventDate,
        timeFrom: input.timeFrom,
        timeTo: input.timeTo);
  }
}
