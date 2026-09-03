class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  final double rating;
  final int stock;
  final String category;
  final String brand;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.rating,
    required this.stock,
    required this.category,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      category: json['category'] ?? '',
      brand: json['brand'] ?? 'No Brand',
    );
  }
}