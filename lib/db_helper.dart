import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dog.dart';

class DBHelper {
  // // static final DBHelper _instance = DBHelper.internal();
  // //
  // // static Database _db;
  // // DBHelper.internal();
  // //
  // // factory DBHelper() => _instance;
  // static final DBHelper _instance = new DBHelper.internal();
  //
  // factory DBHelper() => _instance;
  // static Database _db;
  //
  // DBHelper.internal();
  static Database? _database;
  static DBHelper? _databaseHelper; //SINGLETON DBHELPER
  DBHelper._createInstance(); //NAMED CONST TO CREATE INSTANCE OF THE DBHELPER
  factory DBHelper async {
    if (_databaseHelper == null) {
      _databaseHelper =
          DBHelper._createInstance(); //EXEC ONLY ONCE (SINGLETON OBJ)
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //GET THE PATH TO THE DIRECTORY FOR IOS AND ANDROID TO STORE DB
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "note.db";

    //OPEN/CREATE THE DB AT A GIVEN PATH
    var notesDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
  }


  // Future<Database> get getDB async {
  //   if (_db != null) return _db;
  //   _db = await setDB();
  //   return _db;
  // }

  setDB() async {
    // io.Directory directory = await getApplicationDocumentsDirectory();
    // String path = join(directory.path, "SimpleNoteDB");
//    await ((await openDatabase(path)).close());
//    await deleteDatabase(path);

    final database = openDatabase(join(await getDatabasesPath(), 'dog_db.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
    }, version: 1);
    // var mainDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  Future<void> insertDog(Dog dog) async {
    final dbClient = await getDB;
    await dbClient.insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Dog>> dogs() async {
    final db = await getDB;
    final maps = await db.query('dogs');
    return List.generate(maps.length, (i) {
      return Dog(
          id: maps[i]['id'] as int,
          name: maps[i]['name'] as String,
          age: maps[i]['age'] as int);
    });
  }

  Future<void> updateDog(Dog dog) async {
    final db = await getDB;
    await db.update('dogs', dog.toMap(), where: 'id=?', whereArgs: [dog.id]);
  }

  Future<void> deleteDog(int id) async {
    final db = await getDB;
    await db.delete('dogs', where: 'id=?', whereArgs: [id]);
  }
}
