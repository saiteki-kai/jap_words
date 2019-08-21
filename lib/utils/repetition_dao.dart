import 'package:nihongo_courses/models/repetition.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

class RepetitionDao {
  Future<Database> get _db => DBHelper.db.database;

  static const REPETITION_TABLE = "repetitions";

  getTodayRepetitions() async {
    var db = await _db;
    var timestamp = DateTime.now().millisecondsSinceEpoch;

    await db.query(
      REPETITION_TABLE,
      where: "nextData = ?",
      whereArgs: [timestamp],
    );
  }

  insertRepetition(Repetition item) async {
    var db = await _db;

    await db.insert(
      REPETITION_TABLE,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  updateRepetition(Repetition item) async {
    var db = await _db;

    await db.update(
      REPETITION_TABLE,
      item.toMap(),
      where: "wordId = ?",
      whereArgs: [item.wordId],
    );
  }

  removeRepetition() {}
}
