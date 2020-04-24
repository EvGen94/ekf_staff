import '../model/names.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String TABLE_WORK = "worker";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_SURNAME = "surname";
  static const String COLUMN_MIDDLE_NAME = "middleNname";
  static const String COLUMN_DATE_OF_BIRTH = "dateOfBirth";
  static const String COLUMN_POST = "post";
  static const String COLUMN_CHILDREN = "isChildren";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'ekf_db.db'),
      version: 2,
      onCreate: (Database database, int version) async {
        print("Creating worker table");

        await database.execute(
          "CREATE TABLE $TABLE_WORK ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_NAME TEXT,"
          "$COLUMN_SURNAME TEXT,"
          "$COLUMN_MIDDLE_NAME TEXT,"
          "$COLUMN_DATE_OF_BIRTH TEXT,"
          "$COLUMN_POST TEXT,"
          "$COLUMN_CHILDREN INTEGER"
          ")",
        );
      },
    );
  }

  Future<List<Worker>> getWorkers() async {
    final db = await database;

    var workers = await db.query(TABLE_WORK , columns: [
      COLUMN_ID,
      COLUMN_NAME,
      COLUMN_SURNAME,
      COLUMN_MIDDLE_NAME,
      COLUMN_DATE_OF_BIRTH,
      COLUMN_POST,
      COLUMN_CHILDREN
    ]);

    List<Worker> workerList = List<Worker>();

    workers.forEach((currentWorker) {
      Worker worker = Worker.fromMap(currentWorker);

      workerList.add(worker);
    });

    return workerList;
  }

  Future<Worker> insert(Worker worker) async {
    final db = await database;
    worker.id = await db.insert(TABLE_WORK, worker.toMap());
    return worker;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_WORK,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Worker worker) async {
    final db = await database;

    return await db.update(
      TABLE_WORK,
      worker.toMap(),
      where: "id = ?",
      whereArgs: [worker.id],
    );
  }
}
