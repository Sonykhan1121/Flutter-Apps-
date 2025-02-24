import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("Database path: $path");

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  dueDate TEXT NOT NULL,
  priority INTEGER NOT NULL,
  category TEXT NOT NULL
);
''');
  }

  Future<Task> insertTask(Task task) async {
    final db = await instance.database;
    final id = await db.insert('tasks', task.toMap());
    return task.copyWith(id: id);
  }

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final result = await db.query('tasks');
    print('result: ${result.toString()}');
    return result.map((map) => Task.fromMap(map)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
