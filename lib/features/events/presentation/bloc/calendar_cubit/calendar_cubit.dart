import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial(selectedDate: DateTime.now()));

  void changeDate(DateTime newDate) {
    emit(CalendarInitial(selectedDate: newDate));
  }
}
