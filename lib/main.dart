import 'package:events_app/core/routing/app_routes.dart';
import 'package:events_app/core/routing/app_screens.dart';
import 'package:events_app/features/events/presentation/bloc/calendar_cubit/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //TODO: initialize service locator
  runApp(const EventsApp());
}

class EventsApp extends StatelessWidget {
  const EventsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CalendarCubit()),
      ],
      child: MaterialApp(
        title: 'Events App',
        theme: ThemeData(primaryColor: Colors.white),
        routes: AppScreens.screens,
        initialRoute: AppRoutes.homeScreen,
      ),
    );
  }
}
