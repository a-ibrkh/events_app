part of 'add_or_edit_cubit.dart';

abstract class AddOrEditState extends Equatable {
  const AddOrEditState();

  @override
  List<Object> get props => [];
}

class CheckIsNewEvent extends AddOrEditState {
  @override
  List<Object> get props => [];
}

class AddOrEditInitial extends AddOrEditState {
  final int priorityColor;
  final TextEditingController eventNameController;
  final TextEditingController eventDescriptionController;
  final TextEditingController eventLocationController;
  final TextEditingController eventTime;
  final String? nameError;
  final String? descriptionError;
  final String? locationError;
  final String? timeError;
  final bool canSubmit;
  const AddOrEditInitial({
    this.nameError,
    this.descriptionError,
    this.locationError,
    this.timeError,
    this.canSubmit = false,
    required this.priorityColor,
    required this.eventNameController,
    required this.eventDescriptionController,
    required this.eventLocationController,
    required this.eventTime,
  });
  @override
  List<Object> get props => [
        priorityColor,
        eventDescriptionController,
        eventNameController,
        eventLocationController,
        eventTime,
        nameError ?? '',
        descriptionError ?? '',
        locationError ?? '',
        timeError ?? '',
      ];

  AddOrEditInitial copyWith({
    int? priorityColor,
    TextEditingController? eventNameController,
    TextEditingController? eventDescriptionController,
    TextEditingController? eventLocationController,
    TextEditingController? eventTime,
    String? nameError,
    String? descriptionError,
    String? locationError,
    String? timeError,
    bool? canSubmit,
  }) {
    return AddOrEditInitial(
      priorityColor: priorityColor ?? this.priorityColor,
      eventNameController: eventNameController ?? this.eventNameController,
      eventDescriptionController:
          eventDescriptionController ?? this.eventDescriptionController,
      eventLocationController:
          eventLocationController ?? this.eventLocationController,
      eventTime: eventTime ?? this.eventTime,
      nameError: nameError ?? this.nameError,
      descriptionError: descriptionError ?? this.descriptionError,
      locationError: locationError ?? this.locationError,
      timeError: timeError ?? this.timeError,
      canSubmit: canSubmit??this.canSubmit
    );
  }
}
