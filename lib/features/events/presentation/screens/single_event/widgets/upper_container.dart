import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_textstyles.dart';
import '../../../../domain/entities/event_entity.dart';
import '../../../bloc/events_bloc/events_bloc.dart';
import '../../add_or_edit/add_or_edit_event_screen.dart';
import '../../add_or_edit/arguments/add_or_edit_event_args.dart';

class UpperContainer extends StatelessWidget {
  const UpperContainer({Key? key, required this.event}) : super(key: key);
  final EventEntity event;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: Color(event.eventColorHex),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24.0),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Material(
                    color: Color(event.eventColorHex),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddOrEditEventScreen(
                                args: AddOrEditPageArgs(
                                  selectedDate: event.eventDate,
                                  eventToEdit: event,
                                ),
                              ),
                            )).then((value) {
                          BlocProvider.of<EventsBloc>(context).add(
                            GetEvents(
                              true,
                              DateTime(event.eventDate.year,
                                  event.eventDate.month, event.eventDate.day),
                              const [],
                            ),
                          );
                          Navigator.of(context).pop();
                        });
                      },
                      child: Ink(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            Text(
                              "Edit",
                              style: AppTextStyles.eventDescription
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            Text(
              event.eventName,
              style: AppTextStyles.bigTitle.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.white,
                  size: 16.0,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  "${event.timeFrom} - ${event.timeTo}",
                  style: AppTextStyles.eventDetails.copyWith(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: Colors.white,
                  size: 16.0,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  event.eventLocation,
                  style: AppTextStyles.eventDetails.copyWith(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
