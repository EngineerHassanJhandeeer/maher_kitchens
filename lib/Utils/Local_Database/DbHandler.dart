// import 'package:khan_foods/Models/CartProduct_Model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io' as io;
// import 'package:path/path.dart';

// class DbHelper {
//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initDatabase();
//     return _db;
//   }

//   initDatabase() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(
//       documentDirectory.path,
//       'notes.db',
//     );
//     var db = await openDatabase(path, version: 1, onCreate: onCreate);
//     return db;
//   }

//   onCreate(Database db, int version) async {
//     await db.execute(
//       "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT ,title TEXT,quantity INTEGER,rupees REAL)",
//     );
//   }

//   Future<CartProductModel> insert(CartProductModel model) async {
//     var dbClient = await db;
//     await dbClient!.insert('notes', model.toMap());
//     return model;
//   }

//   Future<List<CartProductModel>> getNotesList() async {
//     var dbClient = await db;
//     final List<Map<String, Object?>> querryResult =
//         await dbClient!.query('notes');
//     return querryResult.map((e) => CartProductModel.fromMap(e)).toList();
//   }

//   Future<int> delete(int id) async {
//     var dbClient = await db;
//     return await dbClient!.delete(
//       'notes',
//       where: 'id= ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> update(CartProductModel model) async {
//     var dbClient = await db;
//     return await dbClient!.update(
//       'notes',
//       model.toMap(),
//       where: 'id = ?',
//       whereArgs: [model.productId],
//     );
//   }
// }

import 'package:khan_foods/Models/CartProduct_Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static const String databaseName = 'product.db';
  static const int version = 1;

  static Future<Database?> database() async {
    if (_db != null) {
      return _db;
    }
    return _db = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: _onCreate,
    );
  }
}

void _onCreate(Database db, int version) async {
  await db.execute(CartProductModel.createTable);
}
  /// var databasesPath = await getDatabasesPath();
  ///   String path = join(databasesPath, 'demo.db');
  ///   Database database = await openDatabase(path, version: 1,
  ///       onCreate: (Database db, int version) async {
  ///     // When creating the db, create the table
  ///     await db.execute(
  ///         'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
  ///   });