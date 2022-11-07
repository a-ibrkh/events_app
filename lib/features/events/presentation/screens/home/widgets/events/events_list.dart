import 'package:events_app/core/utils/app_colors.dart';
import 'package:events_app/features/events/presentation/screens/single_event/single_event_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_textstyles.dart';
import '../../../../bloc/events_bloc/events_bloc.dart';
import 'event_widget.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return BlocConsumer<EventsBloc, EventsState>(
      listener: (context, state) {
        if (state is Success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.successMessage),
            backgroundColor: AppColors.customBlue,
          ));
        }
        if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: AppColors.customRed,
          ));
        }
        if (state is EventsGotten) {
          scrollController.addListener(() {
            if (scrollController.offset >=
                    scrollController.position.maxScrollExtent &&
                !scrollController.position.outOfRange) {
              BlocProvider.of<EventsBloc>(context).add(
                GetEvents(
                  false,
                  DateTime(
                      selectedDate.year, selectedDate.month, selectedDate.day),
                  state.events,
                ),
              );
            }
          });
        }
      },
      builder: (context, state) {
        return BlocBuilder<EventsBloc, EventsState>(builder: (context, state) {
          if (state is EventsGotten) {
            return ListView.separated(
              controller: scrollController,
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                return EventWidget(
                  event: state.events[index],
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 1,
                            child: SingleEventBottomsheetBuilder(
                                event: state.events[index]),
                          );
                        }).then((_) {
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
                );
              },
              separatorBuilder: (_, __) {
                return const SizedBox(
                  height: 8.0,
                );
              },
            );
          } else if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is EventsEmpty) {
            return const Center(
              child: Text(
                "No events for this day",
                style: AppTextStyles.smallTitle,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
      },
    );
  }
}
