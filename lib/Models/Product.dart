class Product {
  final String id;
  final String name;
  final double price;
  final double discount;
  final double finalPrice;
  final String description;
  final List<String> size;
  final List<String> color;
  final int quantity;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.finalPrice,
    required this.description,
    required this.size,
    required this.color,
    required this.quantity,
    required this.imageUrl,
    required this.category, // 👈 added
  });

  /// ✅ Create Product from Firestore map
  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    final price = (data['price'] is num) ? (data['price'] as num).toDouble() : 0.0;
    final discount = (data['discount'] is num) ? (data['discount'] as num).toDouble() : 0.0;

    return Product(
      id: documentId,
      name: data['name'] ?? '',
      price: price,
      discount: discount,
      finalPrice: data['finalPrice'] != null
          ? (data['finalPrice'] as num).toDouble()
          : price - (price * discount / 100), // 👈 calculate if not stored
      description: data['description'] ?? '',
      size: List<String>.from(data['size'] ?? []),
      color: List<String>.from(data['color'] ?? []),
      quantity: (data['quantity'] is num) ? (data['quantity'] as num).toInt() : 0,
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'discount': discount,
      'description': description,
      'finalPrice': finalPrice,
      'size': size,
      'color': color,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'category': category, // 👈 added
    };
  }
}
