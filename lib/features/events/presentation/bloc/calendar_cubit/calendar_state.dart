part of 'calendar_cubit.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {
  final DateTime selectedDate;

  const CalendarInitial({required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];
}
