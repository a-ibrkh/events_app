import 'package:events_app/core/utils/app_textstyles.dart';
import 'package:events_app/features/events/domain/entities/event_entity.dart';
import 'package:events_app/features/events/presentation/screens/single_event/widgets/upper_container.dart';
import 'package:flutter/material.dart';

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
          padding:const EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            event.eventDescription,
            style: AppTextStyles.eventDescription.copyWith(color: Colors.grey, fontSize: 14.0),
          ),
        ),

      ],
    );
  }
}
