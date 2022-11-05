import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:events_app/features/events/data/datasources/local_datasource_impl.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/events_repository.dart';
import '../models/event_model.dart';

//@Injectable(as: EventsRepository)
class EventsRepositoryImpl implements EventsRepository {
  final Converter<EventModel, EventEntity> _converterToEntity;
  final Converter<EventEntity, EventModel> _converterToModel;
  final EventsLocalDatasource eventsLocalDatasource;
  EventsRepositoryImpl(this._converterToEntity, this._converterToModel,
      this.eventsLocalDatasource);
  @override
  Future<Either<Failure, bool>> addEvent(EventEntity event) async {
    try {
      final result = await eventsLocalDatasource
          .insertEvent(_converterToModel.convert(event));
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
      var eventEntityList =
          list.map((e) => _converterToEntity.convert(e)).toList();
      return Right(eventEntityList);
    } on CacheException {
      return Left(CacheFailure("Unable to get events"));
    } catch (e) {
      return Left(UndefinedFailure("error"));
    }
  }

  @override
  Future<Either<Failure, bool>> updateEvent(EventEntity event) async {
    try {
      final result = await eventsLocalDatasource
          .updateEvent(_converterToModel.convert(event));
      return Right(result);
    } on CacheException {
      return Left(CacheFailure("Unable to update event"));
    } catch (e) {
      return Left(UndefinedFailure("Undefined Error"));
    }
  }
}
