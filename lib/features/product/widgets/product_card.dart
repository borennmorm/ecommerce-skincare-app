import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../favorite/presentation/controllers/favorite_controller.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final String image;
  final VoidCallback onTap;

  ProductCard({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.onTap,
    super.key,
  });

  final FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$$price',
                        style: const TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(
                        () => IconButton(
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            favoriteController.isFavorite(id)
                                ? Iconsax.heart5
                                : Iconsax.heart,
                            color: favoriteController.isFavorite(id)
                                ? Colors.pink
                                : Colors.grey.shade400,
                            size: 20,
                          ),
                          onPressed: () {
                            favoriteController.toggleFavorite(
                              FavoriteProduct(
                                id: id,
                                name: name,
                                price: price,
                                image: image,
                              ),
                            );
                            Get.snackbar(
                              favoriteController.isFavorite(id) 
                                  ? 'Added to Favorites' 
                                  : 'Removed from Favorites',
                              favoriteController.isFavorite(id)
                                  ? '$name has been added to your favorites'
                                  : '$name has been removed from your favorites',
                              snackPosition: SnackPosition.TOP,
                              duration: const Duration(seconds: 2),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 