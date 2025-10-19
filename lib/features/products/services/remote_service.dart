import 'package:ecommerce_app/features/products/services/product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class FirebaseProductService implements ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ProductModel>> getRecommendedProducts() async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('rating', isGreaterThan: 4.5)
          .limit(10)
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Firebase Error (Recommended): $e');
      throw Exception('Failed to load recommended products.');
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('isFeatured', isEqualTo: true)
          .limit(10)
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Firebase Error (Featured): $e');
      throw Exception('Failed to load featured products.');
    }
  }

  @override
  Future<List<ProductModel>> getOnSaleProducts() async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('oldPrice', isNull: false)
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Firebase Error (On Sale): $e');
      throw Exception('Failed to load on sale products.');
    }
  }
}
