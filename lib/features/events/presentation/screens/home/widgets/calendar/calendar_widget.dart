import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_textstyles.dart';
import '../../../../bloc/calendar_cubit/calendar_cubit.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key, required this.selectedDate})
      : super(key: key);
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final int year = selectedDate.year;
    final int month = selectedDate.month;
    final int startOfMonth = DateTime(year, month, 1).weekday;
    final int daysInMonth = DateUtils.getDaysInMonth(year, month);
    final int daysInPreviousMonth = DateUtils.getDaysInMonth(
      month == 1 ? year - 1 : year,
      month == 1 ? 12 : month - 1,
    );
    final int weeksInMonth =
        ((startOfMonth == 6 || startOfMonth == 7) && daysInMonth == 31) ||
                (startOfMonth == 7 && daysInMonth == 30)
            ? 6
            : 5;
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int weekIndex = 0; weekIndex < weeksInMonth; weekIndex++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int dayInWeekIndex = 0;
                    dayInWeekIndex < 7;
                    dayInWeekIndex++)
                  Builder(
                    builder: (context) {
                      final bool isNextMonth =
                          7 * weekIndex + dayInWeekIndex + 2 - startOfMonth >
                              daysInMonth;
                      final bool isPreviousMonth =
                          7 * weekIndex + dayInWeekIndex + 1 < startOfMonth;
                      final String displayedDay = (isNextMonth ||
                              isPreviousMonth
                          ? isPreviousMonth
                              ? '${7 * weekIndex + dayInWeekIndex + 2 - startOfMonth + daysInPreviousMonth}'
                              : '${(7 * weekIndex + dayInWeekIndex + 2 - startOfMonth - daysInMonth)}'
                          : '${7 * weekIndex + dayInWeekIndex + 2 - startOfMonth}');
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            (MediaQuery.of(context).size.width - 56.0) / 7),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              if (isNextMonth || isPreviousMonth) return;
                              BlocProvider.of<CalendarCubit>(context)
                                  .changeDate(
                                DateTime(year, month, int.parse(displayedDay)),
                              );
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (int.parse(displayedDay) ==
                                            selectedDate.day) &&
                                        (!isPreviousMonth && !isNextMonth)
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                              height: MediaQuery.of(context).size.height / 18,
                              width:
                                  (MediaQuery.of(context).size.width - 56.0) /
                                      7,
                              child: Center(
                                child: Text(
                                  displayedDay,
                                  style: AppTextStyles.calendarDates.copyWith(
                                    color: isNextMonth || isPreviousMonth
                                        ? Colors.grey
                                        : (int.parse(displayedDay) ==
                                                    selectedDate.day) &&
                                                (!isPreviousMonth &&
                                                    !isNextMonth)
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            )
        ],
      ),
    );
  }
}
