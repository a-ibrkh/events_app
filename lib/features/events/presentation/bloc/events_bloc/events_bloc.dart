import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/event_entity.dart';
import '../../../domain/usecases/add_event.dart' as add;
import '../../../domain/usecases/delete_event.dart' as delete;
import '../../../domain/usecases/get_events_for_one_day.dart' as get_event;
import '../../../domain/usecases/update_event.dart' as update;

part 'events_event.dart';
part 'events_state.dart';

//injectable
class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final add.AddEventUsecase addEvent;
  final update.UpdateEventUsecase updateEvent;
  final delete.DeleteEventUsecase deleteEvent;
  final get_event.GetEventsForOneDay getEventsForOneDay;
  EventsBloc({
    required this.addEvent,
    required this.updateEvent,
    required this.deleteEvent,
    required this.getEventsForOneDay,
  }) : super(EventsEmpty()) {
    on<GetEvents>((event, emit) async {
      await _getEvents(event, emit);
    });
    on<AddEvent>((event, emit) async {
      await _addEvent(event, emit);
    });
    on<UpdateEvent>((event, emit) async {
      await _updateEvent(event, emit);
    });
    on<DeleteEvent>((event, emit) async {
      await _deleteEvent(event, emit);
    });
  }
  Future<void> _getEvents(GetEvents event, Emitter<EventsState> emit) async {
    emit(Loading());
    final failureOrListOfEvents =
        await getEventsForOneDay.call(get_event.Params(
      date: event.date,
      limit: event.limit,
      offset: event.offset,
    ));
    failureOrListOfEvents.fold((failure) async {
      emit(const Error("Unable to get events"));
    }, (listOfEvents) async {
      emit(
        EventsGotten(listOfEvents),
      );
    });
  }

  Future<void> _addEvent(AddEvent event, Emitter<EventsState> emit) async {
    emit(Loading());
    final failureOrAddedEvent =
        await addEvent.call(add.Params(event: event.event));
    failureOrAddedEvent
        .fold((failure) => emit(const Error("Could not add event")), (isAdded) {
      print("is added $isAdded");
      emit(isAdded
          ? const Success("Successfully added")
          : const Error("Could not add event"));
    });
  }

  Future<void> _updateEvent(
      UpdateEvent event, Emitter<EventsState> emit) async {
    emit(Loading());
    final failureOrUpdatedEvent =
        await updateEvent.call(update.Params(event: event.event));
    failureOrUpdatedEvent.fold(
        (failure) => emit(const Error("Could not update event")), (isUpdated) {
      emit(isUpdated
          ? const Success("Successfully updated")
          : const Error("Could not update event"));
    });
  }

  Future<void> _deleteEvent(
      DeleteEvent event, Emitter<EventsState> emit) async {
    emit(Loading());
    final failureOrDeletedEvent =
        await deleteEvent.call(delete.Params(eventId: event.eventId));
    failureOrDeletedEvent.fold(
        (failure) => emit(const Error("Could not delete event")), (isDeleted) {
      emit(isDeleted
          ? const Success("Successfully deleted")
          : const Error("Could not delete event"));
    });
  }
}
