import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_textstyles.dart';
import '../../../../bloc/events_bloc/events_bloc.dart';
import '../../../add_or_edit/add_or_edit_event_screen.dart';
import '../../../add_or_edit/arguments/add_or_edit_event_args.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({Key? key, required this.selectedDate})
      : super(key: key);
  final DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Material(
        child: InkWell(
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddOrEditEventScreen(
                    args: AddOrEditPageArgs(
                      selectedDate: selectedDate,
                    ),
                  ),
                )).then((value) {
              BlocProvider.of<EventsBloc>(context).add(
                GetEvents(
                  true,
                  DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day),
                  const [],
                ),
              );
            });
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
                style:
                    AppTextStyles.calendarDates.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
