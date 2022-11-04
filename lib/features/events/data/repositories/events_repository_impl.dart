import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:events_app/features/events/data/datasources/local_datasource.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/events_repository.dart';
import '../models/event_model.dart';

//@Injectable(as: EventsRepository)
class EventsRepositoryImpl implements EventsRepository {
  final Converter<EventModel, EventEntity> _converter;
  final EventsLocalDatasource eventsLocalDatasource;
  EventsRepositoryImpl(this._converter, this.eventsLocalDatasource);
  @override
  Future<Either<Failure, bool>> addEvent(EventModel event) async {
    try {
      final result = await eventsLocalDatasource.insertEvent(event);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure("Unable to insert"));
    } catch (e) {
      return Left(UndefinedFailure("Undefined Error"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteEvent(String eventId) async {
    try {
      final result = await eventsLocalDatasource.deleteEvent(eventId);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure("Row with current id not found"));
    } catch (e) {
      return Left(UndefinedFailure("Undefined Error"));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents(
      DateTime date, int offset, int limit) async {
    try {
      List<EventModel> list = await eventsLocalDatasource.getEventsForOneDay(
          date.toIso8601String(), offset, limit);
      var eventEntityList = list.map((e) => _converter.convert(e)).toList();
      return Right(eventEntityList);
    } on CacheException {
      return Left(CacheFailure("Unable to get events"));
    } catch (e) {
      return Left(UndefinedFailure("error"));
    }
  }

  @override
  Future<Either<Failure, bool>> updateEvent(EventModel event) async {
    try {
      final result = await eventsLocalDatasource.updateEvent(event);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure("Unable to update event"));
    } catch (e) {
      return Left(UndefinedFailure("Undefined Error"));
    }
  }
}
