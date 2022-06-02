import 'dart:io';

import 'package:ecommerce_app/models/models.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperCart {
  static final DatabaseHelperCart _instance =
      DatabaseHelperCart.internal();

  factory DatabaseHelperCart() => _instance;

  final String _tableCarts = "Carts";
  final String _columnId = "id";
  final String _columnModel = "model";
  final String _columnImage = "image";
  final String _columnPrice = "price";
  final String _columnQty = "qty";
  final String _columnProductId = "product_id";
  final String _columnUsername = "username";

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  DatabaseHelperCart.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join((documentDirectory.path),
        'maindb2.db'); // home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $_tableCarts($_columnId TEXT PRIMARY KEY, $_columnModel TEXT, $_columnImage TEXT, $_columnPrice DOUBLE, $_columnProductId TEXT, $_columnUsername TEXT, $_columnQty INTEGER)");
  }

  /// INSERT
  Future<int> addToCart(Cart product) async {
    var dbClient = await db;
    int res = await dbClient!.insert(_tableCarts, product.toJson());
    return res;
  }

  /// READ
  Future<List<Cart>?> getCartItems() async {
    var dbClient = await db;
    List<Map<String, Object?>> res =
        await dbClient!.rawQuery("SELECT * FROM $_tableCarts");
    if (res.isEmpty) return null;
    return res.map((e) => Cart.fromJson(e)).toList();
  }

  Future<int> removeFromCarts(String id) async {
    var dbClient = await db;
    int res = await dbClient!
        .delete(_tableCarts, where: "$_columnId=?", whereArgs: [id]);
    return res;
  }

  Future<int> updateCart(Cart product) async {
    var dbClient = await db;
    int res = await dbClient!.update(_tableCarts, product.toJson(),
        where: '$_columnId=?', whereArgs: [product.id]);
    return res;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient!.close();
  }
}
