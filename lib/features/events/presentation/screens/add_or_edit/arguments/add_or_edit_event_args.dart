import 'package:events_app/features/events/domain/entities/event_entity.dart';

class AddOrEditPageArgs {
  final DateTime selectedDate;
  final EventEntity? eventToEdit;

  AddOrEditPageArgs({
    required this.selectedDate,
    this.eventToEdit,
  });
}
