part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
  @override
  List<Object> get props => [];
}

class GetEvents extends EventsEvent {
  final DateTime date;
  final List<EventEntity> events;
  final bool isInitialLoad;

  const GetEvents(
    this.isInitialLoad,
    this.date,
    this.events,
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
