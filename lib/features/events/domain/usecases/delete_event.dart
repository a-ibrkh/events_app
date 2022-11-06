import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/events_repository.dart';
//injectable
class DeleteEventUsecase implements UseCase<bool, Params> {
  final EventsRepository _repository;

  DeleteEventUsecase(this._repository);

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
