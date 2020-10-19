import 'dart:io';
import 'package:mosa_bin/models/db_loc.dart';
import 'package:mosa_bin/models/db_trash.dart';
import 'package:mosa_bin/models/db_user.dart';
import 'package:mosa_bin/models/record_trash.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;

  DBHelper._createObject();

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mymosa.db');
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDB);
    return todoDatabase;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT,
      email TEXT,
      birthDate TEXT,
      nickname TEXT,
      fotoPath TEXT,
      totalWeight REAL,
      countBottle INTEGER,
      cash INTEGER
    )
    ''');
    await db.execute('''
    CREATE TABLE bank(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      daerah TEXT,
      pj TEXT,
      kontak TEXT,
      alamat TEXT,
      lat REAL,
      long REAL
    )
    ''');
    await db.execute('''
    CREATE TABLE sampah(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      tipe TEXT,
      harga INTEGER
    )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  Future<int> authUser(String username, String password) async {
    final Database db = await database;
    List<Map<String, dynamic>> temp = await db.rawQuery(
        'SELECT * FROM users WHERE username=? AND password=?',
        [username, password]);
    return temp.length;
  }

  Future<UserDB> findUser(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> temp =
        await db.rawQuery('SELECT * FROM users WHERE username=?', [username]);
    return UserDB.fromMap(temp[0]);
  }

  Future<int> countUser(String username) async {
    final Database db = await database;
    List<Map<String, dynamic>> temp =
        await db.rawQuery('SELECT * FROM users WHERE username=?', [username]);
    return temp.length;
  }

  Future<void> insertUser(UserDB data) async {
    final Database db = await database;
    await db.insert(
      'users',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(UserDB data) async {
    final db = await database;
    await db.update(
      'users',
      data.toMap(),
      where: "id = ?",
      whereArgs: [data.id],
    );
  }

  Future<List<LocDB>> getAllLoc() async {
    Database db = await database;
    List<Map<String, dynamic>> temp = await db.rawQuery('SELECT * FROM bank');
    List<LocDB> res = [];
    for (Map<String, dynamic> t in temp) res.add(LocDB.fromMap(t));
    return res;
  }

  Future<void> insertLoc(LocDB loc) async {
    final Database db = await database;
    await db.insert(
      'bank',
      loc.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TrashDB>> getAllTrash() async {
    Database db = await database;
    List<Map<String, dynamic>> temp = await db.rawQuery('SELECT * FROM sampah');
    List<TrashDB> res = [];
    for (Map<String, dynamic> t in temp) res.add(TrashDB.fromMap(t));
    return res;
  }

  Future<void> insertTrash(TrashDB trash) async {
    final Database db = await database;
    await db.insert(
      'sampah',
      trash.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
