import 'package:sqflite/sqflite.dart';
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';

class FavoriteDB {
  static FavoriteDB? _instance;
  static Database? _database;
  static const String _tableName = 'favorites';

  FavoriteDB._internal() {
    _instance = this;
  }

  factory FavoriteDB() => _instance ?? FavoriteDB._internal();

  Future<Database?> get database async => _database ??= await _initializeDB();

  Future<Database> _initializeDB () async {
    var path = await getDatabasesPath();
    print('path: $path');
    var db = openDatabase(
      '$path/app.db',
      onCreate: (db, version) async {
        await db.execute(
          '''
            CREATE TABLE $_tableName (
              id TEXT PRIMARY KEY,
              name TEXT,
              city TEXT,
              rating REAL
            )
          '''
        );
      },
      version: 1
    );

    return db;
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    final db = await database;

    await db!.insert(_tableName, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableName);

    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableName, where: 'id = ?', whereArgs: [id]);

    return results.isNotEmpty ? results.first : {};
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}