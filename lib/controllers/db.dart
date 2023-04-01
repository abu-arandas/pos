import '/exports.dart';
import 'package:path/path.dart';

class Db {
  static Database? _db;

  /* ====== DataBase ======*/
  Future<Database?> get db async {
    if (_db != null) return _db!;
    _db = await initialDb();

    return _db!;
  }

  initialDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'pos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Category Table
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Category (
            id INTEGER NOT NULL PRIMARY KEY,
            title TEXT NOT NULL
          ) 
        ''');

        // Product Table
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Products (
            id INTEGER NOT NULL PRIMARY KEY,
            title TEXT NOT NULL,
            image TEXT NOT NULL,
            price DECIMAL NOT NULL,
            category INTEGER NOT NULL,
            FOREIGN KEY (category) REFERENCES category(id)
          ) 
        ''');

        // Order Table
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Orders (
            id INTEGER NOT NULL PRIMARY KEY,
            date DATETIME NOT NULL
          ) 
        ''');

        // Order Products Table
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Order_Products (
            id INTEGER NOT NULL PRIMARY KEY,
            title TEXT NOT NULL,
            image TEXT NOT NULL,
            price DECIMAL NOT NULL,
            orderId INTEGER NOT NULL,
            cartQuantity INTEGER NOT NULL,
            FOREIGN KEY (orderId) REFERENCES Orders(id)
          ) 
        ''');
      },
    );
  }

  /* ====== Read ======*/
  Future<List<Map<String, dynamic>>> readData({required String table}) async {
    Database? myDb = await db;

    return myDb!.query(table);
  }

  /* ====== Insert ======*/
  static insertData({required String table, required Map<String, dynamic> item}) async {
    Database? myDb = _db;

    return myDb!.insert(table, item);
  }

  /* ====== Update ======*/
  static updateData({required String table, required Map<String, dynamic> item}) async {
    Database? myDb = _db;

    return myDb!.update(table, item, where: 'id = ${item['id']}');
  }

  /* ====== Delete ======*/
  static deleteData({required String table, required int id}) async {
    Database? myDb = _db;

    return myDb!.delete(table, where: 'id = $id');
  }
}
