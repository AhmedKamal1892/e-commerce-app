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
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num).toDouble(),
      category: json['category'] as String,
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
}
