// import 'package:khan_foods/Models/CartProduct_Model.dart';

// import 'package:sqflite/sqflite.dart';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class ProductDbProvider {
//   Future<bool> insertProduct(CartProductModel model) async {
//     Database? database = await DbHelper.database();
//     int rows =
//         await database!.insert(CartProductModel.tableName, model.toMap());
//     if (rows < 0) {
//       return false;
//     }
//     return true;
//   }

//   Future<bool> updateProduct(CartProductModel model) async {
//     Database? database = await DbHelper.database();
//     int rows = await database!.update(
//         CartProductModel.tableName,
//         {
//           CartProductModel.columnQuantity: model.quantity,
//           CartProductModel.columnPrice: model.price
//         },
//         where: '${CartProductModel.columnProductId} = ? ',
//         whereArgs: [model.productId]);
//     if (rows > 0) {
//       return true;
//     }
//     return false;
//   }

//   Future<bool> deleteProduct(CartProductModel model) async {
//     Database? database = await DbHelper.database();
//     int rows = await database!.delete(CartProductModel.tableName,
//         where: '${CartProductModel.columnProductId}= ?',
//         whereArgs: [model.productId]);
//     if (rows > 0) {
//       return true;
//     }
//     return false;
//   }

//   Future<bool> deleteAllProducts() async {
//     Database? database = await DbHelper.database();
//     int rows = await database!.delete('productTable');
//     if (rows > 0) {
//       return true;
//     }
//     return false;
//   }

//   Future<List<CartProductModel>> fetchProductFromDb() async {
//     Database? database = await DbHelper.database();
//     List list = await database!.query(CartProductModel.tableName);
//     return list.map((e) => CartProductModel.fromMap(e)).toList();
//   }
// }

// class DbHelper {
//   static Database? _db;
//   static const String databaseName = 'product.db';
//   static const int version = 1;

//   static Future<Database?> database() async {
//     if (_db != null) {
//       return _db;
//     }
//     return _db = await openDatabase(
//       join(await getDatabasesPath(), databaseName),
//       version: version,
//       onCreate: _onCreate,
//     );
//   }
// }

// void _onCreate(Database db, int version) async {
//   await db.execute(CartProductModel.createTable);
// }

// import 'package:khan_foods/Models/CartProduct_Model.dart';
// import 'package:khan_foods/Utils/Local_Database/DbHandler.dart';
// import 'package:sqflite/sqflite.dart';

// class ProductDbProvider {
//   Future<bool> insertProduct(CartProductModel model) async {
//     Database? database = await DbHelper.database();
//     int rows =
//         await database!.insert(CartProductModel.tableName, model.toMap());
//     if (rows < 0) {
//       return false;
//     }
//     return true;
//   }

//   Future<bool> updateProduct(CartProductModel model) async {
//     Database? database = await DbHelper.database();
//     int rows = await database!.update(
//         CartProductModel.tableName,
//         {
//           CartProductModel.columnQuantity: model.quantity,
//           CartProductModel.columnPrice: model.price
//         },
//         where: '${CartProductModel.columnProductId} = ? ',
//         whereArgs: [model.productId]);
//     if (rows > 0) {
//       return true;
//     }
//     return false;
//   }

//   Future<bool> deleteProduct(CartProductModel model) async {
//     Database? database = await DbHelper.database();
//     int rows = await database!.delete(CartProductModel.tableName,
//         where: '${CartProductModel.columnProductId}= ?',
//         whereArgs: [model.productId]);
//     if (rows > 0) {
//       return true;
//     }
//     return false;
//   }

//   Future<bool> deleteAllProducts() async {
//     Database? database = await DbHelper.database();
//     int rows = await database!.delete('productTable');
//     if (rows > 0) {
//       return true;
//     }
//     return false;
//   }

//   Future<List<CartProductModel>> fetchProductFromDb() async {
//     Database? database = await DbHelper.database();
//     List list = await database!.query(CartProductModel.tableName);
//     return list.map((e) => CartProductModel.fromMap(e)).toList();
//   }
// }

import 'package:khan_foods/Models/CartProduct_Model.dart';
import 'package:khan_foods/Utils/Local_Database/DbHandler.dart';
import 'package:sqflite/sqflite.dart';

class ProductDbProvider {
  Future<bool> insertProduct(CartProductModel model) async {
    Database? database = await DbHelper.database();
    int rows =
        await database!.insert(CartProductModel.tableName, model.toMap());
    if (rows < 0) {
      return false;
    }
    return true;
  }

  Future<bool> updateProduct(CartProductModel model) async {
    Database? database = await DbHelper.database();
    int rows = await database!.update(
        CartProductModel.tableName,
        {
          CartProductModel.columnQuantity: model.quantity,
          CartProductModel.columnPrice: model.price
        },
        where: '${CartProductModel.columnProductId} = ? ',
        whereArgs: [model.productId]);
    if (rows > 0) {
      return true;
    }
    return false;
  }

  Future<bool> deleteProduct(CartProductModel model) async {
    Database? database = await DbHelper.database();
    int rows = await database!.delete(CartProductModel.tableName,
        where: '${CartProductModel.columnProductId}= ?',
        whereArgs: [model.productId]);
    if (rows > 0) {
      return true;
    }
    return false;
  }

  Future<bool> deleteAllProducts() async {
    Database? database = await DbHelper.database();
    int rows = await database!.delete('productTable');
    if (rows > 0) {
      return true;
    }
    return false;
  }

  Future<List<CartProductModel>> fetchProductFromDb() async {
    Database? database = await DbHelper.database();
    List list = await database!.query(CartProductModel.tableName);
    return list.map((e) => CartProductModel.fromMap(e)).toList();
  }
}
