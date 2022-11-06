import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/calendar_cubit/calendar_cubit.dart';
import 'widgets/calendar/calendar_app_bar.dart';
import 'widgets/calendar/calendar_widget.dart';
import 'widgets/calendar/change_year_and_month_widget.dart';
import 'widgets/calendar/weekdays_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        if (state is CalendarInitial) {
          final DateTime selectedDate = state.selectedDate;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: CalendarAppBar(selectedDate: selectedDate),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.notifications),
                )
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
              child: Column(
                children: [
                  YearAndMonthWidget(selectedDate: selectedDate),
                  const SizedBox(height: 18.0),
                  const WeekdaysWidget(),
                  CalendarWidget(selectedDate: selectedDate),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
