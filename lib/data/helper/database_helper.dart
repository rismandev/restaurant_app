import 'package:siresto_app/data/model/index.dart';
import 'package:sqflite/sqflite.dart';

/*  Database Helper
    Handle Create Local Database
    [_initializeDb] => Initialize Database Scheme
    [_tblFavorite] => Initialize favorites for table name
    [insertFavorite] => Insert item to table favorite
    [getFavorites] => Get item from table favorite
    [getFavoriteById] => Get item from table favorite by ID
    [removeFavorite] => Remove item from table favorite by ID

    Date Created                      Date Updated
    21 November 2020                  21 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }
    return _databaseHelper;
  }

  static const String _tblFavorite = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/newsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
             id VARCHAR PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertFavorite(Merchant merchant) async {
    final db = await database;
    await db.insert(_tblFavorite, merchant.toJson());
  }

  Future<List<Merchant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> _results = await db.query(_tblFavorite);

    return _results.map((res) => Merchant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> _results = await db.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (_results.isNotEmpty) {
      return _results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
