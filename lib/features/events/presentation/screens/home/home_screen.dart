import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_textstyles.dart';
import '../../bloc/calendar_cubit/calendar_cubit.dart';
import '../../bloc/events_bloc/events_bloc.dart';
import 'widgets/calendar/calendar_app_bar.dart';
import 'widgets/calendar/calendar_widget.dart';
import 'widgets/calendar/change_year_and_month_widget.dart';
import 'widgets/calendar/weekdays_widget.dart';
import 'widgets/events/add_event_button.dart';
import 'widgets/events/events_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarCubit, CalendarState>(
      listener: (context, state) {
        if (state is CalendarInitial) {
          BlocProvider.of<EventsBloc>(context).add(
            GetEvents(
              true,
              DateTime(state.selectedDate.year, state.selectedDate.month,
                  state.selectedDate.day),
              const [],
            ),
          );
        }
      },
      builder: (context, state) {
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 32.0),
                  child: Column(
                    children: [
                      YearAndMonthWidget(selectedDate: selectedDate),
                      const SizedBox(height: 18.0),
                      const WeekdaysWidget(),
                      CalendarWidget(selectedDate: selectedDate),
                      const SizedBox(height: 18.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Schedule",
                            style: AppTextStyles.smallTitle,
                          ),
                          AddEventButton(selectedDate: selectedDate),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Expanded(
                        child: EventsList(selectedDate: selectedDate),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
