import 'package:ecommer_skincare_app/features/product/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_details_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      backgroundColor: Colors.grey[100],

      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildProductCard();
        },
      ),
    );
  }

  Widget _buildProductCard() {
    return ProductCard(
      id: 'product-${DateTime.now().millisecondsSinceEpoch}',
      name: 'Hydrating Serum',
      price: 24.99,
      image: 'https://www.sephora.com/productimages/sku/s2743060-main-zoom.jpg?imwidth=1224',
      onTap: () => Get.to(() => const ProductDetailsPage()),
    );
  }
}
