import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/event_entity.dart';

abstract class EventsRepository {
  ///get events of specific date with pagination
  Future<Either<Failure, List<EventEntity>>> getEvents(
      DateTime date, int offset, int limit);

  ///add event to a specific date
  Future<Either<Failure, bool>> addEvent(EventEntity event);

  ///delete event
  Future<Either<Failure, bool>> deleteEvent(String eventId);

  ///update event
  Future<Either<Failure, bool>> updateEvent(EventEntity event);
}
