import 'dart:ffi';

class TestModel {
  int id;
  String description;
  bool isDone = false;

  //when using {} param are optional / named
  TestModel({this.id, this.description, this.isDone});

  factory TestModel.fromDatabaseJson(Map<String, dynamic> data) => TestModel(
    //convert Json objet that are coming from querying the database and convert it into current model
    id: data['id'],
    description: data['description'],
    //sqlite doesn't have boolean type 
    isDone: data['is_done'] == 0 ? false : true
  );

  Map<String, dynamic> toDatabaseJson() => {
    //convert object that are going to be stored in sqlite
    "id": this.id,
    "description": this.description,
    "is_done": this.isDone == false ? 0 : 1 
  };
}