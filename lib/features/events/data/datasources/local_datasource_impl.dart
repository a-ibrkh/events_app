import 'package:events_app/core/database/database_init.dart';
import 'package:events_app/core/errors/exceptions.dart';
import 'package:events_app/core/utils/app_constants.dart';
import 'package:events_app/core/utils/app_keys.dart';
import 'package:events_app/features/events/data/models/event_model.dart';
import 'package:events_app/features/events/helpers/helper_functions.dart';
//injectable
class EventsLocalDatasource {
  final DatabaseInit dbInstance;

  EventsLocalDatasource({required this.dbInstance});

  Future<bool> insertEvent(EventModel event) async {
    final db = await dbInstance.database;
    final id = await db.insert(AppKeys.eventsTable, event.toMap());
    if (id == 0) {
      throw CacheException();
    }
    return id != 0;
  }

  Future<List<EventModel>> getEventsForOneDay(
      String dateTimeIsoString, int offset, int limit) async {
    final db = await dbInstance.database;
    final listOfMaps = await db.query(
      AppKeys.eventsTable,
      columns: AppConstants.sqlEventColumns,
      where: "${AppKeys.eventDate} = ?",
      whereArgs: [dateTimeIsoString],
      offset: offset,
      limit: limit,
    );

    return HelperFunctions.convertMapToEventModel(listOfMaps);
  }

  Future<bool> updateEvent(EventModel event) async {
    final db = await dbInstance.database;
    final id = await db.update(
      AppKeys.eventsTable,
      event.toMap(),
      where: "${AppKeys.eventId} = ?",
      whereArgs: [event.eventId],
    );
    if (id == 0) {
      throw CacheException();
    }
    return id != 0;
  }

  Future<bool> deleteEvent(String eventId) async {
    final db = await dbInstance.database;
    final id = await db.delete(
      AppKeys.eventsTable,
      where: "${AppKeys.eventId} = ?",
      whereArgs: [eventId],
    );
    if (id == 0) {
      throw CacheException();
    }
    return id != 0;
  }
}
