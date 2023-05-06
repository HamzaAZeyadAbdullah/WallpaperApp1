import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLiteDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialdb();
      return _db;
    } else {
      return _db;
    }
  }

  initialdb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'hz.db'); //databasePath/hz.db
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 30, onUpgrade: _onupgrade);
    return mydb;
  }

  _onupgrade(Database db, int oldversion, int newversion) async {
    print("_onupgrade==========");
    await db.execute('ALTER TABLE images ADD COLUMN color TEXT');
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
  CREATE TABLE "images"(
    "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "image" TEXT NOT NULL
  ) 

''');
    await batch.commit();

    print("_onCreate==========");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'hz.db');

    await deleteDatabase(path);
  }
}
