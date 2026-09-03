import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import 'product_detail_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductService productService = ProductService();
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. พื้นหลังครีมอุ่นๆ แบบธรรมชาติ แทนสีเทาเย็น
      backgroundColor: const Color(0xFFFAF6EF),
      
      appBar: AppBar(
        // 2. ปรับ AppBar ให้ดูคลีน ไม่มีเงา
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Products',
          style: TextStyle(
            color: Color(0xFF4A453D), // น้ำตาลเข้มอบอุ่น แทนเทาอมน้ำเงิน
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),

      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ปรับสีตัวโหลดให้เข้ากับธีม
            return const Center(child: CircularProgressIndicator(color: Color(0xFF8A9A8B))); 
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          final productList = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(20), // เพิ่มพื้นที่ขอบให้ดูโปร่งขึ้น
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16, // ขยายช่องว่างระหว่างการ์ด
              mainAxisSpacing: 16,
              childAspectRatio: 0.65,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];

              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // นำ MouseRegion มาครอบไว้ชั้นนอกสุด
    return MouseRegion(
      cursor: SystemMouseCursors.click, // บังคับเปลี่ยนเคอร์เซอร์เมาส์เป็นรูปมือ
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8E1D4), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8A9A8B).withOpacity(0.10),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFF1ECE1),
                    padding: const EdgeInsets.all(12), 
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.contain, 
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, color: Color(0xFFA39C8C));
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF4A453D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Color(0xFFD98C6B), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 12, color: Color(0xFFA39C8C)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5F6F60), 
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}