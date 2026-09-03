import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF6EF),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF4A453D)),
        title: const Text(
          'Product Detail',
          style: TextStyle(
            color: Color(0xFF4A453D),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Product Image
            Hero(
              tag: 'product-image-${product.id}',
              child: Container(
                width: double.infinity,
                height: 320,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1ECE1),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8A9A8B).withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  product.thumbnail,
                  fit: BoxFit.contain,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 80,
                        color: Color(0xFFA39C8C),
                      ),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD98C6B).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.category.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFFD98C6B),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Product Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A453D),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Rating
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE8E1D4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFD98C6B),
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A453D),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5F6F60),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Info card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE8E1D4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand
                        _buildInfoRow(
                          icon: Icons.business,
                          title: 'Brand',
                          value: product.brand,
                        ),

                        const SizedBox(height: 14),

                        // Category
                        _buildInfoRow(
                          icon: Icons.category,
                          title: 'Category',
                          value: product.category,
                        ),

                        const SizedBox(height: 14),

                        // Stock
                        Row(
                          children: [
                            const Icon(
                              Icons.inventory_2,
                              color: Color(0xFF8A9A8B),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Stock:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A453D),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: (product.stock > 10
                                        ? const Color(0xFF8A9A8B)
                                        : const Color(0xFFD98C6B))
                                    .withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${product.stock} items',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: product.stock > 10
                                      ? const Color(0xFF5F6F60)
                                      : const Color(0xFFD98C6B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A453D),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Color(0xFF8A8478),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),

      // Add to Cart Button
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAF6EF),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8A9A8B).withOpacity(0.15),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A9A8B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF5F6F60),
                    content: Text(
                      '${product.title} added to cart',
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
              ),
              label: const Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF8A9A8B),
        ),

        const SizedBox(width: 12),

        Text(
          '$title:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A453D),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF8A8478),
            ),
          ),
        ),
      ],
    );
  }
}