import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class UndefinedFailure extends Failure {
  final String errorMessage;

  UndefinedFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class CacheFailure extends Failure {
    final String errorMessage;

  CacheFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
