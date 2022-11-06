import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../../../core/utils/app_textstyles.dart';
import '../../../../bloc/calendar_cubit/calendar_cubit.dart';
import 'change_month_button.dart';

class YearAndMonthWidget extends StatelessWidget {
  const YearAndMonthWidget({Key? key, required this.selectedDate})
      : super(key: key);
  final DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DropdownButton<int>(
            elevation: 0,
            value: selectedDate.year,
            items: List.generate(
              1001,
              (index) => DropdownMenuItem<int>(
                value: 1950 + index,
                child: Text(
                  '${1950 + index}',
                  style: AppTextStyles.calendarDates,
                ),
              ),
            ),
            onChanged: (year) {
              BlocProvider.of<CalendarCubit>(context).changeDate(
                DateTime(
                  year ?? selectedDate.year,
                  1,
                  1,
                ),
              );
            }),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          AppConstants.monthsName[selectedDate.month - 1],
          style: AppTextStyles.smallTitle,
        ),
        const Spacer(),
        ChangeMonthButton(
          onTap: () {
            BlocProvider.of<CalendarCubit>(context).changeDate(DateTime.now());
          },
          icon: Icons.restore,
        ),
        const SizedBox(
          width: 8.0,
        ),
        ChangeMonthButton(
          onTap: () {
            if (selectedDate.month == 1 && selectedDate.year == 1950) return;
            BlocProvider.of<CalendarCubit>(context).changeDate(
              DateTime(
                selectedDate.month == 1
                    ? selectedDate.year - 1
                    : selectedDate.year,
                selectedDate.month == 1 ? 12 : selectedDate.month - 1,
              ),
            );
          },
          icon: Icons.arrow_back_ios_new,
        ),
        const SizedBox(
          width: 8.0,
        ),
        ChangeMonthButton(
          onTap: () {
            if (selectedDate.month == 12 && selectedDate.year == 2950) return;
            BlocProvider.of<CalendarCubit>(context).changeDate(
              DateTime(
                selectedDate.month == 12
                    ? selectedDate.year + 1
                    : selectedDate.year,
                selectedDate.month == 12 ? 1 : selectedDate.month + 1,
              ),
            );
          },
          icon: Icons.arrow_forward_ios,
        ),
      ],
    );
  }
}
