import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:events_app/core/errors/exceptions.dart';
import 'package:events_app/core/errors/failure.dart';
import 'package:events_app/features/events/data/models/event_model.dart';
import 'package:events_app/features/events/domain/entities/event_entity.dart';

abstract class EventsRepository {
  ///get events of specific date with pagination
  Future<Either<Failure, List<EventEntity>>> getEvents(
      DateTime date, int offset, int limit);

  ///add event to a specific date
  Future<Either<Failure, bool>> addEvent(EventModel event);

  ///delete event
  Future<Either<Failure, bool>> deleteEvent(String eventId);

  ///update event
  Future<Either<Failure, bool>> updateEvent(EventModel event);
}


