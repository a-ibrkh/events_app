import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../domain/entities/event_entity.dart';

part 'add_or_edit_state.dart';

class AddOrEditCubit extends Cubit<AddOrEditState> {
  AddOrEditCubit() : super(CheckIsNewEvent());
  void checkIsNewEvent(EventEntity? event) {
    if (event == null) {
      emit(
        AddOrEditInitial(
          priorityColor: AppColors.customBlue.value,
          eventNameController: TextEditingController(),
          eventDescriptionController: TextEditingController(),
          eventLocationController: TextEditingController(),
          eventTime: TextEditingController(),
        ),
      );
    } else {
      emit(
        AddOrEditInitial(
          priorityColor: event.eventColorHex,
          eventNameController: TextEditingController(text: event.eventName),
          eventDescriptionController:
              TextEditingController(text: event.eventDescription),
          eventLocationController:
              TextEditingController(text: event.eventLocation),
          eventTime: TextEditingController(
              text: "${event.timeFrom} - ${event.timeTo}"),
        ),
      );
    }
  }

  void validateTextFields(AddOrEditInitial state) {
    String? nameError;
    String? descriptionError;
    String? locationError;
    String? timeError;
    bool canSubmit = true;
    if (state.eventNameController.text.isEmpty) {
      nameError = "Name is empty";
      canSubmit = false;
    } else {
      nameError = '';
    }
    if (state.eventDescriptionController.text.isEmpty) {
      descriptionError = "Description is empty";
      canSubmit = false;
    } else {
      descriptionError = '';
    }
    if (state.eventLocationController.text.isEmpty) {
      locationError = "Location is empty";
      canSubmit = false;
    } else {
      locationError = '';
    }
    if (state.eventTime.text.isEmpty) {
      timeError = "Time is empty";
      canSubmit = false;
    } else if (state.eventTime.text.length == 13) {
      String timeEntered = state.eventTime.text.replaceAll(" - ", "");
      timeEntered = timeEntered.replaceAll(":", "");
      String from = timeEntered.replaceRange(4, null, "");
      String to = timeEntered.replaceRange(0, 4, "");
      int fromHours = int.parse(from.replaceRange(2, null, ""));
      int fromMinutes = int.parse(from.replaceRange(0, 2, ""));
      int toHours = int.parse(to.replaceRange(2, null, ""));
      int toMinutes = int.parse(to.replaceRange(0, 2, ""));
      // print(
      //     " .  $timeEntered >> $from >> $to >> $fromHours >$fromMinutes >> $toHours > $toMinutes");
      if (fromHours > 23 ||
          fromMinutes > 59 ||
          toHours > 23 ||
          toMinutes > 59) {
        timeError = "Incorrect time";
        canSubmit = false;
      } else if ((toHours < fromHours )||((toHours == fromHours) && (fromMinutes > toMinutes))) {
        timeError = "Ending time can not be earlier than starting time";
        canSubmit = false;
      }  else {
        timeError = '';
      }
    }
    emit(
      state.copyWith(
        nameError: nameError,
        descriptionError: descriptionError,
        locationError: locationError,
        timeError: timeError,
        canSubmit: canSubmit,
      ),
    );
  }

  void priorityColorChanged(AddOrEditInitial newState) {
    emit(newState);
  }
}
