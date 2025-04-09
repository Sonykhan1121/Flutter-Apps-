import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final _databaseName = "users.db";
  static final _databaseVersion = 3;

  static final table = "users";
  static final columnId = "id";
  static final columnName = "name";
  static final columnEmployeeId = "employeeId";
  static final columnDesignation = "designation";
  static final columnAddress = "address";
  static final columnEmail = "email";
  static final columnContactNumber = "contactNumber";
  static final columnDeviceId = 'deviceId';
  static final columnSalary = "salary";
  static final columnOvertimeRate = "overtimeRate";
  static final columnStartDate = 'startDate';
  static final columnStartTime = 'startTime';
  static final columnEmbedding = "embedding";
  static final columnImageFile = "imageFile"; // New column for storing file (NOT NULL)

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnEmployeeId TEXT NOT NULL UNIQUE,
        $columnDesignation TEXT NOT NULL,
        $columnAddress TEXT NOT NULL,
        $columnEmail TEXT NOT NULL UNIQUE,
        $columnContactNumber TEXT NOT NULL,
        $columnDeviceId TEXT NOT NULL UNIQUE,
        $columnSalary REAL NOT NULL,
        $columnOvertimeRate REAL NOT NULL,
        $columnStartDate DATE,
        $columnStartTime TIME,
        $columnEmbedding BLOB NOT NULL,
        $columnImageFile BLOB NOT NULL  
      )
    ''');

    await db.execute(''' 
      CREATE INDEX idx_email ON $table($columnEmail)
    ''');
    await db.execute(''' 
      CREATE INDEX idx_employeeId ON $table($columnEmployeeId)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute('DROP TABLE IF EXISTS $table');
      await _onCreate(db, newVersion);
    }
  }

  // Insert a user into the database
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;

    // Ensure that imageFile is provided and not null
    if (user[columnImageFile] == null) {
      throw Exception("Image file is required");
    }

    return await db.insert(
      table,
      {

        columnName: user[columnName],
        columnEmployeeId: user[columnEmployeeId],
        columnDesignation: user[columnDesignation],
        columnAddress: user[columnAddress],
        columnEmail: user[columnEmail],
        columnContactNumber: user[columnContactNumber],
        columnDeviceId: user[columnDeviceId],
        columnSalary: user[columnSalary],
        columnOvertimeRate: user[columnOvertimeRate],
        columnStartDate: user[columnStartDate],
        columnStartTime: user[columnStartTime],
        columnEmbedding: _floatListToBytes(user[columnEmbedding] as List<double>),
        columnImageFile: user[columnImageFile], // Store image as BLOB (NOT NULL)
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Check if an email exists in the database
  Future<bool> emailExists(String email) async {
    final db = await database;
    final result = await db.query(
      table,
      where: '$columnEmail = ?',
      whereArgs: [email],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  // Get all users from the database
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    final results = await db.query(table);
    return results.map((row) {
      return {
        columnId: row[columnId],
        columnName: row[columnName],
        columnEmployeeId: row[columnEmployeeId],
        columnDesignation: row[columnDesignation],
        columnAddress: row[columnAddress],
        columnEmail: row[columnEmail],
        columnContactNumber: row[columnContactNumber],
        columnDeviceId : row[columnDeviceId],
        columnSalary: row[columnSalary],
        columnOvertimeRate: row[columnOvertimeRate],
        columnStartDate: row[columnStartDate],
        columnStartTime: row[columnStartTime],
        columnEmbedding: _bytesToFloatList(row[columnEmbedding] as Uint8List),
        columnImageFile: row[UserDatabase.columnImageFile], // Convert BLOB back to file
      };
    }).toList();
  }

  // Update an existing user
  Future<void> updateUser(int columnId ,String oldName, String newName) async {
    final db = await database;


    await db.update(
      table,
      {
        columnName: newName,

      },
      where: '$columnId = ?',
      whereArgs: [columnId],
    );
  }
  Future<void> deleteUser(int cid) async
  {
    final db = await database;

    await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [cid],
    );
  }

  // Convert a list of float numbers to bytes (for embedding)
  Uint8List _floatListToBytes(List<double> embedding) {
    final byteData = ByteData(embedding.length * 4);
    for (int i = 0; i < embedding.length; i++) {
      byteData.setFloat32(i * 4, embedding[i], Endian.little);
    }
    return byteData.buffer.asUint8List();
  }

  // Convert bytes back to a list of float numbers (for embedding)
  List<double> _bytesToFloatList(Uint8List bytes) {
    final byteData = ByteData.sublistView(bytes);
    return List.generate(
      bytes.length ~/ 4,
          (i) => byteData.getFloat32(i * 4, Endian.little),
    );
  }


  // Close the database
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> clearUsers() async {
    final db = await database;
    await db.delete('users'); // replace 'users' with your actual table name
  }

}
