//Manage all local databse CRUD operation asynchronously
//Main communicator between Repository and DatabaseProvider
import 'package:flutter_base_bloc_sqlite/database/database.dart';
import 'package:flutter_base_bloc_sqlite/model/test.dart';

class TestDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Add new records
  Future<int> createTodo(TestModel testModel) async {
    final db = await dbProvider.database;
    var result = db.insert(testTable, testModel.toDatabaseJson());
    return result;
  }

  //Get all items
  //Searches if query was passed
  Future<List<TestModel>> getAllItems({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(
          testTable,
          columns: columns,
          where: 'description LIKE ?',
          whereArgs: ["%$query%"]
        );
      }
    } else {
      result = await db.query(
        testTable,
        columns: columns
      );
    }

    List<TestModel> items = result.isNotEmpty
      ? result.map((item) => TestModel.fromDatabaseJson(item)).toList()
      : [];
    return items;
  }

  //Update record
  Future<int> updateItem(TestModel testModel) async {
    final db = await dbProvider.database;
    var result = await db.update(
      testTable,
      where: 'id = ?',
      whereArgs: [testModel.id]
    );
    return result;
  }

  //Delete record
  Future<int> DeleteItem(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(
      testTable,
      where: 'id = ?',
      whereArgs: [id]
    );
    return result;
  }

  //Delete all records
  Future deleteAllItems() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      testTable
    );
    return result;
  }
}