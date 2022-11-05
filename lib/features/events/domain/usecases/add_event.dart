import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event_entity.dart';
import '../repositories/events_repository.dart';

class AddEvent implements UseCase<bool, Params> {
  final EventsRepository _repository;

  AddEvent(this._repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.addEvent(params.event);
  }
}

class Params extends Equatable {
  final EventEntity event;
  const Params({
    required this.event,
  });
  @override
  List<Object?> get props => [event];
}
