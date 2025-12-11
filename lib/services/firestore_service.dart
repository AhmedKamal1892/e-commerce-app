import 'dart:convert';
import 'dart:io';
import 'package:adminpage/Models/Category.dart';
import 'package:adminpage/Models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uuid = const Uuid();


  Future<String> encodeImageToBase64(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      print('❌ Image encoding failed: $e');
      rethrow;
    }
  }


  Future<void> addProduct(Product product) async {
    try {
      await _db.collection('products').doc(product.id).set({
        'id': product.id,
        'name': product.name,
        'price': product.price,
        // 'review': product.review,
        'finalPrice':product.finalPrice,
        'category':product.category,
        'discount': product.discount,
        'description': product.description,
        'size': product.size,
        'color': product.color,
        'Quantity': product.quantity,
        'imageUrl': product.imageUrl, // base64 string
        'createdAt': FieldValue.serverTimestamp(),
      });
      print(' Product added successfully');
    } catch (e) {
      print(' Failed to add product: $e');
      rethrow;
    }
  }


  Future<void> updateProduct(Product product) async {
    try {
      await _db.collection('products').doc(product.id).update({
        'name': product.name,
        'price': product.price,
        // 'review': product.review,
        'category':product.category,
        'discount': product.discount,
        'description': product.description,
        'size': product.size,
        'color': product.color,
        'Quantity': product.quantity,
        'imageUrl': product.imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print(' Product updated successfully');
    } catch (e) {
      print(' Failed to update product: $e');
      rethrow;
    }
  }


  Future<void> deleteProduct(String id) async {
    try {
      await _db.collection('products').doc(id).delete();
      print('🗑 Product deleted successfully');
    } catch (e) {
      print(' Failed to delete product: $e');
      rethrow;
    }
  }


  Stream<QuerySnapshot> getProducts() {
    return _db.collection('products').orderBy('createdAt', descending: true).snapshots();
  }


  Future<void> addCategory(Category category) async {
    try {
      await _db.collection('categories').doc(category.id).set({
        'id': category.id,
        'name': category.name,
        'imageUrl': category.imageUrl, // base64 string
        'createdAt': FieldValue.serverTimestamp(),
      });
      print(' Category added successfully');
    } catch (e) {
      print(' Failed to add category: $e');
      rethrow;
    }
  }


  Future<void> updateCategory(Category category) async {
    try {
      await _db.collection('categories').doc(category.id).update({
        'name': category.name,
        'imageUrl': category.imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print(' Category updated successfully');
    } catch (e) {
      print(' Failed to update category: $e');
      rethrow;
    }
  }


  Future<void> deleteCategory(String id) async {
    try {
      await _db.collection('categories').doc(id).delete();
      print('🗑 Category deleted successfully');
    } catch (e) {
      print('Failed to delete category: $e');
      rethrow;
    }
  }


  Stream<QuerySnapshot> getCategories() {
    return _db.collection('categories').orderBy('createdAt', descending: true).snapshots();
  }
}
