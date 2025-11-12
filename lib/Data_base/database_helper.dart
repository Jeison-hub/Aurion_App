import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aurion.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    // usuario por defecto
    await db.insert('users', {
      'username': 'Admin',
      'email': 'admin@example.com',
      'password': 'password'
    });
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await instance.database;
    final res = await db.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (res.isNotEmpty) return res.first;
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  Future<int> deleteAllUsers() async {
    final db = await instance.database;
    return await db.delete('users');
  }
}
