import '../../models/product_model.dart';
import '../product_service.dart';
import 'database_helper.dart';

class LocalProductService implements ProductService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Future<List<ProductModel>> getRecommendedProducts() async {
    try {
      return await _dbHelper.getProductsByQuery(
        "SELECT * FROM products WHERE rating > ? ORDER BY rating DESC LIMIT 10",
        [4.5],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getOnSaleProducts() async {
    try {
      return await _dbHelper.getProductsByQuery(
        "SELECT * FROM products WHERE oldPrice IS NOT NULL AND oldPrice > price",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      return await _dbHelper.getProductsByQuery(
        "SELECT * FROM products WHERE isFeatured = ?",
        [1],
      );
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
  //   try {
  //     return await _dbHelper.getProductsByQuery(
  //       "SELECT * FROM products WHERE category = ?",
  //       [categoryName],
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> saveProducts(List<ProductModel> products) async {
    if (products.isNotEmpty) {
      await _dbHelper.insertProducts(products);
    }
  }

  Future<void> saveProductsForCategory(
    String categoryName,
    List<ProductModel> products,
  ) async {
    if (products.isNotEmpty) {
      await _dbHelper.insertProducts(products);
    }
  }

  Future<void> clearAllProductsCache() async {
    await _dbHelper.clearProducts();
  }

  Future<void> clearAllCache() async {
    await clearAllProductsCache();
  }
}
