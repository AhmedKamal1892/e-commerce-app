import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/product_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'ecommerce_cache.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        imageUrl TEXT,
        price REAL,
        oldPrice REAL,
        rating REAL,
        category TEXT,
        isFeatured INTEGER
      )
    ''');
  }

  Future<void> insertProducts(List<ProductModel> products) async {
    final db = await database;
    final batch = db.batch();
    for (var product in products) {
      batch.insert(
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<ProductModel>> getProductsByQuery(
    String query, [
    List<Object?>? arguments,
  ]) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(query, arguments);
    if (maps.isEmpty) {
      throw Exception('No products found for query in local DB.');
    }
    return List.generate(maps.length, (i) => ProductModel.fromMap(maps[i]));
  }

  Future<void> clearProducts() async {
    final db = await database;
    await db.delete('products');
  }
}
