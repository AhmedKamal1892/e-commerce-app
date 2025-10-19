class ProductModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final double rating;
  final String category;
  final bool isFeatured;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.category,
    this.isFeatured = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? '',
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'category': category,
      'isFeatured': isFeatured,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'category': category,
      'isFeatured': isFeatured ? 1 : 0,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      price: map['price'] as double? ?? 0.0,
      oldPrice: map['oldPrice'] as double?,
      rating: map['rating'] as double? ?? 0.0,
      category: map['category'] as String? ?? '',
      isFeatured: (map['isFeatured'] as int?) == 1,
    );
  }
}
