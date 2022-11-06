part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
  @override
  List<Object> get props => [];
}

class GetEvents extends EventsEvent {
  final DateTime date;
  final int offset;
  final int limit;

  const GetEvents(
    this.date,
    this.offset,
    this.limit,
  );

  @override
  List<Object> get props => [date];
}

class AddEvent extends EventsEvent {
  final EventEntity event;

  const AddEvent(this.event);

  @override
  List<Object> get props => [event];
}

class UpdateEvent extends EventsEvent {
  final EventEntity event;

  const UpdateEvent(this.event);

  @override
  List<Object> get props => [event];
}

class DeleteEvent extends EventsEvent {
  final String eventId;

  const DeleteEvent(this.eventId);
  @override
  List<Object> get props => [eventId];
}
