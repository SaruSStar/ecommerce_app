import 'dart:io';

import 'package:ecommerce_app/models/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelperFavorite {
  static final DatabaseHelperFavorite _instance =
      DatabaseHelperFavorite.internal();

  factory DatabaseHelperFavorite() => _instance;

  final String _tableFavorite = "Favorites";
  final String _columnId = "id";
  final String _columnName = "name";
  final String _columnCategory = "category";
  final String _columnBrand = "brand";
  final String _columnModel = "model";
  final String _columnPrice = "price";
  final String _columnColour = "colour";
  final String _columnWeight = "weight";
  final String _columnImage = "image";

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  DatabaseHelperFavorite.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join((documentDirectory.path),
        'maindb1.db'); // home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $_tableFavorite($_columnId TEXT PRIMARY KEY, $_columnName TEXT, $_columnCategory TEXT, $_columnBrand TEXT, $_columnModel TEXT, $_columnPrice DOUBLE, $_columnColour TEXT, $_columnWeight TEXT, $_columnImage TEXT)");
  }

  /// INSERT
  Future<int> addToFavourite(Product product) async {
    var dbClient = await db;
    int res = await dbClient!.insert(_tableFavorite, product.toJson());
    return res;
  }

  /// READ
  Future<List<Product>?> getFavoriteItems() async {
    var dbClient = await db;
    List<Map<String, Object?>> res =
        await dbClient!.rawQuery("SELECT * FROM $_tableFavorite");
    if (res.isEmpty) return null;
    return res.map((e) => Product.fromJson(e)).toList();
  }

  Future<int> removeFromFavorite(String id) async {
    var dbClient = await db;
    int res = await dbClient!
        .delete(_tableFavorite, where: "$_columnId=?", whereArgs: [id]);
    return res;
  }

  Future<int> updateFavorite(Product product) async {
    var dbClient = await db;
    int res = await dbClient!.update(_tableFavorite, product.toJson(),
        where: '$_columnId=?', whereArgs: [product.id]);
    return res;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient!.close();
  }
}
