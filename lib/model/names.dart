import '../db/database_provider.dart';

class Worker {
  int id;
  String name;
  String surname;
  String middleName;
  String dateOfBirth;
  String post;
  bool isChildren;

  Worker({
    this.id,
    this.name,
    this.surname,
    this.middleName,
    this.dateOfBirth,
    this.post,
    this.isChildren,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_SURNAME: surname,
      DatabaseProvider.COLUMN_MIDDLE_NAME: middleName,
      DatabaseProvider.COLUMN_DATE_OF_BIRTH: dateOfBirth,
      DatabaseProvider.COLUMN_POST: post,
      DatabaseProvider.COLUMN_CHILDREN: isChildren ? 1 : 0
      
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Worker.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    surname = map[DatabaseProvider.COLUMN_SURNAME];
    middleName = map[DatabaseProvider.COLUMN_MIDDLE_NAME];
    dateOfBirth = map[DatabaseProvider.COLUMN_DATE_OF_BIRTH];
    post = map[DatabaseProvider.COLUMN_POST];
    isChildren = map[DatabaseProvider.COLUMN_CHILDREN] == 1;

    
  }
}
