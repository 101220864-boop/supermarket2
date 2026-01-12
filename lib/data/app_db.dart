
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modle/score_record.dart';

class AppDb {
  AppDb._();
  static final AppDb instance = AppDb._();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'game.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE scores(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            playerName TEXT,
            score INTEGER,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertScore(ScoreRecord record) async {
    final db = await database;
    await db.insert('scores', record.toMap());
  }

  Future<List<ScoreRecord>> getScores() async {
    final db = await database;
    final maps = await db.query('scores', orderBy: 'id DESC');
    return maps.map((m) => ScoreRecord.fromMap(m)).toList();
  }

  Future<void> deleteScore(int id) async {
    final db = await database;
    await db.delete('scores', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateScore(ScoreRecord record) async {
    final db = await database;
    await db.update(
      'scores',
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }
}
