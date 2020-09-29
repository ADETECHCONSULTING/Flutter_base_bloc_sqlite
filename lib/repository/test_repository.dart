//act as a proxy bridge between different data sources provider
import 'package:flutter_base_bloc_sqlite/dao/test_dao.dart';
import 'package:flutter_base_bloc_sqlite/model/test.dart';

class TestRepository {
  final testDao = TestDao();

  Future getAllTodos({String query}) {
    return testDao.getAllItems(query: query);
  }

  Future insertItem(TestModel testModel) {
    return testDao.createItem(testModel);
  }

  Future updateItem(TestModel testModel) {
    return testDao.updateItem(testModel);
  }

  Future deleteTodoById(int id) {
    return testDao.DeleteItem(id);
  }

  Future deleteAllItems() {
    return testDao.deleteAllItems();
  }
}