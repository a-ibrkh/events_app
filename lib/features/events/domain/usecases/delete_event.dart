import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/events_repository.dart';

class DeleteEvent implements UseCase<bool, Params> {
  final EventsRepository _repository;

  DeleteEvent(this._repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.deleteEvent(params.eventId);
  }
}

class Params extends Equatable {
  final String eventId;
  const Params({
    required this.eventId,
  });
  @override
  List<Object?> get props => [eventId];
}
