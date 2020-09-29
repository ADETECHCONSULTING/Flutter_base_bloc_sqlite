
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final testTable = 'TestExample';
class DatabaseProvider {
  // private constructor that can be used only inside the class
  static final DatabaseProvider dbProvider = DatabaseProvider();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onUpgrade: onUpgrade, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE $testTable ("
          "id INTEGER PRIMARY KEY,"
          "description TEXT,"
          "is_done INTEGER "
          ")"
      );
    });
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if(newVersion > oldVersion){}
  }

}

