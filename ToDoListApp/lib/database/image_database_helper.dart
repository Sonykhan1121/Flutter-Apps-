import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do_list/models/image_model.dart';

class ImageDatabaseHelper {
  static final ImageDatabaseHelper instance = ImageDatabaseHelper._init();
  static Database? _database;

  ImageDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('images.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE ImagePaths (
      id $idType,
      path $textType
    )
    ''');
  }

  Future<int> insertImagePath(String path) async {
    final db = await instance.database;
    final json = {'path': path};

   return await db.insert('ImagePaths', json);
  }

  Future<List<Map<String,dynamic>>> getImagePaths() async {
    final db = await instance.database;
    final results = await db.query('ImagePaths');

    return results.toList();
  }

  Future<void> deleteImagePath(int id) async {
    final db = await instance.database;
    await db.delete('ImagePaths', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
