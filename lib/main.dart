import 'package:events_app/core/routing/app_routes.dart';
import 'package:events_app/core/routing/app_screens.dart';
import 'package:events_app/core/utils/theme_data.dart';
import 'package:events_app/features/events/presentation/bloc/add_or_edit_event_cubit/cubit/add_or_edit_cubit.dart';
import 'package:events_app/features/events/presentation/bloc/calendar_cubit/calendar_cubit.dart';
import 'package:events_app/features/events/presentation/bloc/events_bloc/events_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const EventsApp());
}

class EventsApp extends StatelessWidget {
  const EventsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<CalendarCubit>()
            ..changeDate(
              DateTime.now(),
            ),
        ),
        BlocProvider(
          create: (_) => di.sl<AddOrEditCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<EventsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Events App',
        theme: AppThemeData.appTheme,
        routes: AppScreens.screens,
        initialRoute: AppRoutes.homeScreen,
      ),
    );
  }
}
