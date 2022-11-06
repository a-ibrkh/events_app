import 'package:events_app/features/events/domain/entities/event_entity.dart';
import 'package:events_app/features/events/presentation/bloc/events_bloc/events_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masked_text/masked_text.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_textstyles.dart';
import '../../bloc/add_or_edit_event_cubit/cubit/add_or_edit_cubit.dart';
import 'arguments/add_or_edit_event_args.dart';

class AddOrEditEventScreen extends StatefulWidget {
  const AddOrEditEventScreen({
    Key? key,
    required this.args,
  }) : super(key: key);
  final AddOrEditPageArgs args;

  @override
  State<AddOrEditEventScreen> createState() => _AddOrEditEventScreenState();
}

class _AddOrEditEventScreenState extends State<AddOrEditEventScreen> {
  @override
  void initState() {
    BlocProvider.of<AddOrEditCubit>(context)
        .checkIsNewEvent(widget.args.eventToEdit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrEditCubit, AddOrEditState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AddOrEditInitial) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "${widget.args.selectedDate.day} ${AppConstants.monthsName[widget.args.selectedDate.month - 1]} ${widget.args.selectedDate.year}",
                style: AppTextStyles.smallTitle,
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      onChanged: (_) {
                        BlocProvider.of<AddOrEditCubit>(context)
                            .validateTextFields(state);
                      },
                      controller: state.eventNameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        errorText: (state.nameError?.isEmpty ?? true)
                            ? null
                            : state.nameError,
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        label: const Text(
                          "Event name",
                          style: AppTextStyles.smallTitle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      height: 8 * 24.0,
                      child: TextField(
                        onChanged: (_) {
                          BlocProvider.of<AddOrEditCubit>(context)
                              .validateTextFields(state);
                        },
                        controller: state.eventDescriptionController,
                        cursorColor: Colors.black,
                        maxLines: 8,
                        decoration: InputDecoration(
                          errorText: (state.descriptionError?.isEmpty ?? true)
                              ? null
                              : state.descriptionError,
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.2),
                          label: const Text(
                            "Event description",
                            style: AppTextStyles.smallTitle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    TextField(
                      onChanged: (_) {
                        BlocProvider.of<AddOrEditCubit>(context)
                            .validateTextFields(state);
                      },
                      controller: state.eventLocationController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        errorText: (state.locationError?.isEmpty ?? true)
                            ? null
                            : state.locationError,
                        suffixIcon: const Icon(
                          Icons.location_on_rounded,
                          color: AppColors.customBlue,
                        ),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        label: const Text(
                          "Event location",
                          style: AppTextStyles.smallTitle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      "Priority color",
                      style: AppTextStyles.smallTitle,
                    ),
                    DropdownButton<int>(
                      value: state.priorityColor,
                      items: [
                        DropdownMenuItem<int>(
                          value: AppColors.customBlue.value,
                          child: Container(
                            height: 20.0,
                            width: 24.0,
                            color: AppColors.customBlue,
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: AppColors.customRed.value,
                          child: Container(
                            height: 20.0,
                            width: 24.0,
                            color: AppColors.customRed,
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: AppColors.customOrange.value,
                          child: Container(
                            height: 20.0,
                            width: 24.0,
                            color: AppColors.customOrange,
                          ),
                        )
                      ],
                      onChanged: (colorCode) {
                        BlocProvider.of<AddOrEditCubit>(context)
                            .priorityColorChanged(
                          state.copyWith(priorityColor: colorCode),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    MaskedTextField(
                      onChanged: (value) {
                        if (value.length == 13) {
                          FocusScope.of(context).unfocus();
                        }
                        BlocProvider.of<AddOrEditCubit>(context)
                            .validateTextFields(state);
                      },
                      controller: state.eventTime,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      mask: "##:## - ##:##",
                      maxLength: 13,
                      decoration: InputDecoration(
                        errorText: (state.timeError?.isEmpty ?? true)
                            ? null
                            : state.timeError,
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        label: const Text(
                          "Event time",
                          style: AppTextStyles.smallTitle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Material(
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<AddOrEditCubit>(context)
                              .validateTextFields(state);
                          if (state.canSubmit) {
                            BlocProvider.of<EventsBloc>(context).add(
                              AddEvent(
                                EventEntity(
                                  eventColorHex: state.priorityColor,
                                  eventDate: DateTime(
                                      widget.args.selectedDate.year,
                                      widget.args.selectedDate.month,
                                      widget.args.selectedDate.day),
                                  eventDescription:
                                      state.eventDescriptionController.text,
                                  eventId: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  eventLocation:
                                      state.eventLocationController.text,
                                  eventName: state.eventNameController.text,
                                  timeFrom: state.eventTime.text
                                      .replaceRange(5, null, ""),
                                  timeTo: state.eventTime.text
                                      .replaceRange(0, 8, ""),
                                ),
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        child: Ink(
                          height: 48.0,
                          width: MediaQuery.of(context).size.width - 56.0,
                          decoration:
                              const BoxDecoration(color: AppColors.customBlue),
                          child: Center(
                            child: Text(
                              "Add",
                              style: AppTextStyles.smallTitle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
