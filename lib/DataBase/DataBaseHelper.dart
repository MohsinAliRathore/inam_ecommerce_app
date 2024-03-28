
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'product_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Product(id INTEGER PRIMARY KEY, quantity INTEGER)',
        );
      },
    );
  }

  Future<int> insertProduct(int productId, int quantity) async {
    final db = await database;
    return await db.rawInsert('INSERT INTO Product(id, quantity) VALUES(?, ?)',
        [productId, quantity]);
  }

  Future<int> updateProduct(int productId, int quantity) async {
    final db = await database;
    return await db.rawUpdate(
        'UPDATE Product SET quantity = ? WHERE id = ?', [quantity, productId]);
  }

  Future<int> deleteProduct(int productId) async {
    final db = await database;
    return await db.delete('Product', where: 'id = ?', whereArgs: [productId]);
  }

  Future<int> getProductQuantity(int productId) async {
    final db = await database;
    var result = await db.query('Product',
        where: 'id = ?', whereArgs: [productId], columns: ['quantity']);
    if (result.isNotEmpty) {
      return result.first['quantity'] as int;
    } else {
      return 0;
    }
  }

  Future<void> deleteDB() async {
    final path = join(await getDatabasesPath(), 'product_database.db');
    if (await File(path).exists()) {
      await deleteDatabase(path);
      print('Database deleted successfully.');
    } else {
      print('Database file does not exist.');
    }
    // Set _database to null after deletion
    _database = null;
  }

}
