import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper db = DBHelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "repetitions.db");

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Repetition ("
        "wordId TEXT PRIMARY KEY,"
        "easiness INTEGER,"
        "repetitions INTEGER,"
        "interval INTEGER,"
        "nextDate INTEGER"
        ")");
  }
}
