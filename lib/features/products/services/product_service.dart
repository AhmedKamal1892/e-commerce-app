import 'package:ecommerce_app/features/products/models/product_model.dart';
import 'package:flutter/material.dart';

abstract class ProductService {
  Future<List<ProductModel>> getRecommendedProducts();
  Future<List<ProductModel>> getOnSaleProducts();
  Future<List<ProductModel>> getFeaturedProducts();
}
