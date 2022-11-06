import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../../../core/utils/app_textstyles.dart';

class CalendarAppBar extends StatelessWidget {
  const CalendarAppBar({Key? key, required this.selectedDate})
      : super(key: key);
  final DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppConstants.weekdaysFull[selectedDate.weekday - 1],
          style: AppTextStyles.smallTitle,
        ),
        Text(
          "${selectedDate.day} ${AppConstants.monthsName[selectedDate.month - 1]} ${selectedDate.year}",
          style: AppTextStyles.eventDescription,
        ),
      ],
    );
  }
}
