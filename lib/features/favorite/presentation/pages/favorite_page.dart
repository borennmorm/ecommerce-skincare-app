import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/favorite_controller.dart';
import '../../../product/presentation/pages/product_details_page.dart';
import '../../../product/widgets/product_card.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites', style: TextStyle(fontSize: 18,),),
      ),
      backgroundColor: Colors.grey[100],
      body: Obx(() {
        if (favoriteController.favoriteItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.heart,
                  size: 80,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorites yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add items to your favorites',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: favoriteController.favoriteItems.length,
          itemBuilder: (context, index) {
            final product = favoriteController.favoriteItems[index];
            return ProductCard(
              id: product.id,
              name: product.name,
              price: product.price,
              image: product.image,
              onTap: () => Get.to(() => const ProductDetailsPage()),
            );
          },
        );
      }),
    );
  }
} 