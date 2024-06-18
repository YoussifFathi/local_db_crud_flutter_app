import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  static final DatabaseManager instance = DatabaseManager._constructor();
  static Database? _db;

  final String _tableName = "TasksTable";
  final String _idColumn = "id";
  final String _nameColumn = "name";
  final String _isFinishedColumn = "isFinished";

  DatabaseManager._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final String databasePath = join(databaseDirPath, "MainDB.db");

    Database database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute("""
        CREATE TABLE $_tableName (
        $_idColumn INTEGER PRIMARY KEY , 
        $_nameColumn TEXT NOT NULL , 
        $_isFinishedColumn BOOL NOT NULL)
        """);
      },
    );

    return database;
  }

  Future<void> addTask(String taskName) async {
    final db = await database;
    int id = await db.rawInsert(
        "INSERT INTO $_tableName ($_nameColumn , $_isFinishedColumn) VALUES (?, ?)",
        [taskName, 0]);
    print(id);
  }

  Future<List<Map>> fetchAllTasks() async {
    final db = await database;
    List<Map> data = await db.rawQuery("SELECT * FROM $_tableName");
    return data;
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    db.rawDelete("DELETE FROM $_nameColumn WHERE $_idColumn = ?", [id]);
  }

  Future<void> editTask(int id, String newName) async {
    final db = await database;
    await db.rawUpdate(
      "UPDATE $_tableName SET $_nameColumn = ? WHERE $_idColumn = ?",
      [newName, id],
    );
  }

  Future<void> toggleTask(int id, bool isFinished) async {
    final db = await database;
    db.rawUpdate(
        "UPDATE $_tableName SET $_isFinishedColumn = ? WHERE $_idColumn = ?",
        [isFinished ? 1 : 0, id]);
  }
}
