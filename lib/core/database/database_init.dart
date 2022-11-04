import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../utils/app_constants.dart';
import '../utils/app_keys.dart';

//injectable
class DatabaseInit {
  static final DatabaseInit instance = DatabaseInit._init();
  static Database? _database;
  DatabaseInit._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(AppKeys.eventsDB);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(""" 
    CREATE TABLE ${AppKeys.eventsTable}(
      ${AppKeys.eventId} ${AppConstants.sqlStringType},
      ${AppKeys.eventName} ${AppConstants.sqlStringType},
      ${AppKeys.eventDescription} ${AppConstants.sqlStringType},
      ${AppKeys.eventColorHex} ${AppConstants.sqlIntType},
      ${AppKeys.eventLocation} ${AppConstants.sqlStringType},
      ${AppKeys.eventDate} ${AppConstants.sqlStringType},
      ${AppKeys.timeFrom} ${AppConstants.sqlStringType},
      ${AppKeys.timeTo} ${AppConstants.sqlStringType},
    )
    """);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
