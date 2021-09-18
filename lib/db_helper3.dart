import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _dbname = "myDatabase.db";
  static const _dbversion = 1;
  static const _tablename = "dogs";
  static const _columnId = "id";
  static const _columnName = "name";
  static const _columnAge = "age";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DBChangeListener? dbChangeListener;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initiateDatabase();
    return _database;
  }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbname);
    return await openDatabase(
      path,
      version: _dbversion,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database db, int dbversion) async {
    return await db.execute('''
         CREATE TABLE $_tablename (id INTEGER PRIMARY KEY AUTOINCREMENT,
         $_columnName TEXT NOT NULL, $_columnAge INTEGER NOT NULL)
      ''');
  }

  Future<void> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.execute(
        'INSERT INTO $_tablename VALUES(NULL, ${row['name']}, ${row['age']})');
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instance.database;
    return await db!.query(_tablename);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[_columnId];
    return await db!
        .update(_tablename, row, where: '$_columnId=?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_tablename, where: '$_columnId=?', whereArgs: [id]);
  }

  set _dbChangeListener(dbChangeListener) =>
      this.dbChangeListener = dbChangeListener;
}

abstract class DBChangeListener {
  void onChanged();
}
