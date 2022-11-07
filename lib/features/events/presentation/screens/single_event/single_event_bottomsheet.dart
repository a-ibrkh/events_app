import 'package:events_app/core/utils/app_textstyles.dart';
import 'package:events_app/features/events/domain/entities/event_entity.dart';
import 'package:events_app/features/events/presentation/screens/single_event/widgets/upper_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../bloc/events_bloc/events_bloc.dart';

class SingleEventBottomsheetBuilder extends StatelessWidget {
  const SingleEventBottomsheetBuilder({Key? key, required this.event})
      : super(key: key);
  final EventEntity event;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UpperContainer(event: event),
        const SizedBox(
          height: 18.0,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            "Event description",
            style: AppTextStyles.smallTitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            event.eventDescription,
            style: AppTextStyles.eventDescription
                .copyWith(color: Colors.grey, fontSize: 14.0),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Material(
                  child: InkWell(
                      onTap: () {
                        BlocProvider.of<EventsBloc>(context)
                            .add(DeleteEvent(event.eventId));
                        Navigator.of(context).pop();
                      },
                      child: Ink(
                        height: 48.0,
                        width: MediaQuery.of(context).size.width - 56.0,
                        decoration: BoxDecoration(
                            color: AppColors.customRed.withOpacity(0.3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.delete_rounded,
                              color: AppColors.customRed,
                            ),
                            Text(
                              "Delete event",
                              style: AppTextStyles.smallTitle,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
