import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:events_app/core/errors/failure.dart';
import 'package:events_app/core/usecases/usecase.dart';
import 'package:events_app/features/events/domain/entities/event_entity.dart';
import 'package:events_app/features/events/domain/repositories/events_repository.dart';
//injectable
class GetEventsForOneDay implements UseCase<List<EventEntity>, Params> {
  final EventsRepository _repository;

  GetEventsForOneDay(this._repository);
  @override
  Future<Either<Failure, List<EventEntity>>> call(Params params) async {
    return await _repository.getEvents(
        params.date, params.offset, params.limit);
  }
}

class Params extends Equatable {
  final DateTime date;
  final int offset;
  final int limit;

  const Params({
    required this.date,
    required this.offset,
    required this.limit,
  });
  @override
  List<Object?> get props => [date, offset, limit];
}
