part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsEmpty extends EventsState {}

class Error extends EventsState {
  final String errorMessage;

  const Error(this.errorMessage);
}

class Loading extends EventsState {}


class EventsGotten extends EventsState {
  final List<EventEntity> events;

  const EventsGotten(this.events);
}

class Success extends EventsState {
  final String successMessage;
  const Success(
    this.successMessage,
  );
}
