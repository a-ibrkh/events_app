import 'package:events_app/core/utils/app_textstyles.dart';
import 'package:events_app/features/events/presentation/screens/add_or_edit/add_or_edit_event_screen.dart';
import 'package:events_app/features/events/presentation/screens/add_or_edit/arguments/add_or_edit_event_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
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
                  const SizedBox(height: 18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Schedule",
                        style: AppTextStyles.smallTitle,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddOrEditEventScreen(
                                      args: AddOrEditPageArgs(
                                        selectedDate: selectedDate,
                                      ),
                                    ),
                                  ));
                            },
                            child: Ink(
                              width: 102.0,
                              height: 32.0,
                              decoration: const BoxDecoration(
                                color: AppColors.customBlue,
                              ),
                              child: Center(
                                child: Text(
                                  "+ Add event",
                                  style: AppTextStyles.calendarDates
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
  }
}
