
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tp1/data/models/Todo.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notes.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Todo(id TEXT PRIMARY KEY,title TEXT,descrition text,userId TEXT, createdAt date, updateAt date,beginedAt date,deadlinedAt date,finishedAt date);"),
        version: _version);
  }

  static Future<int> addNote(Todo note) async {
    final db = await _getDB();
    return await db.insert("Note", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Todo note) async {
    final db = await _getDB();
    return await db.update("Note", note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(Todo note) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<int?> nonCommencer() async {
    final db = await _getDB();
    List<Map<String, dynamic>> maps = await db.query('Note',
      columns: ['id', 'title' ],
      where: 'beginedAt = null',
    );
    return await maps.length;
  }

  static Future<int?> enCours() async {
    final db = await _getDB();
    List<Map<String, dynamic>> maps = await db.query('Note',
      columns: ['id', 'title' ],
      where: 'finishedAt = null',
    );
    return await maps.length;
  }

  static Future<int?> finie() async {
    final db = await _getDB();
    List<Map<String, dynamic>> maps = await db.query('Note',
      columns: ['id', 'title' ],
      where: 'finishedAt is not null',
    );
    return await maps.length;
  }

  static Future<int?> finiEnRetard() async {
    final db = await _getDB();
    List<Map<String, dynamic>> maps = await db.query('Note',
      columns: ['id', 'title' ],
      where: 'finishedAt > deadlinedAt',
    );
    return await maps.length;
  }


  static Future<List<Todo>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Note");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Todo.fromJson(maps[index]));
  }
}