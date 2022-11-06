//service locator
import 'dart:convert';

import 'package:events_app/core/database/database_init.dart';
import 'package:events_app/features/events/data/datasources/local_datasource_impl.dart';
import 'package:events_app/features/events/data/models/converters/event_converter.dart';
import 'package:events_app/features/events/data/models/event_model.dart';
import 'package:events_app/features/events/domain/entities/event_entity.dart';
import 'package:events_app/features/events/domain/repositories/events_repository.dart';
import 'package:events_app/features/events/domain/usecases/add_event.dart';
import 'package:events_app/features/events/domain/usecases/get_events_for_one_day.dart';
import 'package:events_app/features/events/domain/usecases/update_event.dart';
import 'package:events_app/features/events/presentation/bloc/add_or_edit_event_cubit/cubit/add_or_edit_cubit.dart';
import 'package:events_app/features/events/presentation/bloc/calendar_cubit/calendar_cubit.dart';
import 'package:events_app/features/events/presentation/bloc/events_bloc/events_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/events/data/models/converters/event_entity_to_model.dart';
import 'features/events/data/repositories/events_repository_impl.dart';
import 'features/events/domain/usecases/delete_event.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //blocs
  sl.registerFactory(
    () => EventsBloc(
      addEvent: sl(),
      updateEvent: sl(),
      deleteEvent: sl(),
      getEventsForOneDay: sl(),
    ),
  );

  sl.registerFactory(() => AddOrEditCubit());
  sl.registerFactory(() => CalendarCubit());

  //usecases
  sl.registerLazySingleton(() => AddEventUsecase(sl()));
  sl.registerLazySingleton(() => UpdateEventUsecase(sl()));
  sl.registerLazySingleton(() => DeleteEventUsecase(sl()));
  sl.registerLazySingleton(() => GetEventsForOneDay(sl()));

  //repository
  sl.registerLazySingleton<EventsRepository>(
    () => EventsRepositoryImpl(
      sl(),
      sl(),
      sl(),
    ),
  );

  //datasource
  sl.registerLazySingleton(() => DatabaseInit.instance);
  sl.registerLazySingleton(() => DatabaseInit);
  sl.registerLazySingleton(
    () => EventsLocalDatasource(
      dbInstance: sl(),
    ),
  );
  //converters
  sl.registerLazySingleton<Converter<EventModel, EventEntity>>(
      () => EventConverterToEntity());

  sl.registerLazySingleton<Converter<EventEntity, EventModel>>(
      () => EventConverterToModel());
}
