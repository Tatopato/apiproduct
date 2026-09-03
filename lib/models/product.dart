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
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      
      // ดึงรูปภาพจาก key ชื่อ 'image'
      thumbnail: json['image'] ?? '', 
      
      // เจาะเข้าไปเอาคะแนนเรตติ้งจาก Object
      rating: (json['rating']?['rate'] as num?)?.toDouble() ?? 0.0,
      
      // API นี้ไม่มีสต็อก ใช้จำนวนคนรีวิวแทนชั่วคราว
      stock: json['rating']?['count'] ?? 0, 
      
      category: json['category'] ?? '',
      brand: 'No Brand', 
    );
  }
}