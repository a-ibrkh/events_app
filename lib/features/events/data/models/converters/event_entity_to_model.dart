import 'dart:convert';

import '../event_model.dart';
import '../../../domain/entities/event_entity.dart';

//injectable
class EventConverterToModel extends Converter<EventEntity, EventModel> {
  @override
  EventModel convert(EventEntity input) {
    return EventModel(
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
