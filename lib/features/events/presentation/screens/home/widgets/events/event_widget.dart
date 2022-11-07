import 'package:events_app/core/utils/app_textstyles.dart';
import 'package:events_app/features/events/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({Key? key, required this.event, required this.onTap}) : super(key: key);
  final EventEntity event;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(event.eventColorHex).withOpacity(0.2),
            border: Border(
              top: BorderSide(color: Color(event.eventColorHex), width: 10.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.eventName,
                style: AppTextStyles.smallTitle
                    .copyWith(color: Color(event.eventColorHex)),
              ),
              const SizedBox(height: 4.0),
              Text(
                event.eventDescription,
                style: AppTextStyles.eventDescription.copyWith(
                  color: Color(event.eventColorHex),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.timer,
                    color: Color(event.eventColorHex),
                  ),
                  Text(
                    "${event.timeFrom} - ${event.timeTo}",
                    style: AppTextStyles.eventDetails.copyWith(
                      color: Color(event.eventColorHex),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Icon(
                    Icons.location_on_rounded,
                    color: Color(event.eventColorHex),
                  ),
                  Text(
                    event.eventLocation,
                    style: AppTextStyles.eventDetails.copyWith(
                      color: Color(event.eventColorHex),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
