import 'package:ecommer_skincare_app/features/cart/presentation/controllers/cart_controller.dart';
import 'package:ecommer_skincare_app/features/favorite/presentation/controllers/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final cartController = Get.put(CartController());
  final favoriteController = Get.find<FavoriteController>();
  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;
  int quantity = 1;

  // Product details (you might want to pass these as parameters)
  final String productId = 'product-${DateTime.now().millisecondsSinceEpoch}';
  final String productName = 'Hydrating Serum';
  final double productPrice = 24.99;
  final String productImage = 'https://www.sephora.com/productimages/sku/s2743060-main-zoom.jpg?imwidth=1224';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'https://www.sephora.com/productimages/sku/s2743060-main-zoom.jpg?imwidth=1224',
      'https://www.sephora.com/productimages/product/p443563-av-1-zoom.jpg?imwidth=1224',
      'https://www.sephora.com/productimages/sku/s2743060-av-2-zoom.jpg?imwidth=1224',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Obx(() => IconButton(
            icon: Icon(
              favoriteController.isFavorite(productId)
                  ? Iconsax.heart5
                  : Iconsax.heart,
              color: favoriteController.isFavorite(productId)
                  ? Colors.pink
                  : Colors.grey.shade400,
            ),
            onPressed: () {
              favoriteController.toggleFavorite(
                FavoriteProduct(
                  id: productId,
                  name: productName,
                  price: productPrice,
                  image: productImage,
                ),
              );
              Get.snackbar(
                favoriteController.isFavorite(productId)
                    ? 'Added to Favorites'
                    : 'Removed from Favorites',
                favoriteController.isFavorite(productId)
                    ? '$productName has been added to your favorites'
                    : '$productName has been removed from your favorites',
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 2),
              );
            },
          )),
        ],
      ),
      backgroundColor: Colors.grey[100],

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 300,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      _currentPage.value = index;
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(images[index]),
                            // fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (index) => Obx(() => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage.value == index
                              ? Colors.pink
                              : Colors.grey.withOpacity(0.5),
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Product Details
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hydrating Serum',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$24.99',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'A lightweight, fast-absorbing serum that deeply hydrates and plumps the skin, leaving it soft, smooth, and radiant.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Key Ingredients:',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Hyaluronic Acid\n• Vitamin B5\n• Aloe Vera',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Quantity Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quantity:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      // Decrease Button
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: const Icon(Iconsax.minus, color: Colors.pink),
                      ),
                      // Quantity Display
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Increase Button
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Iconsax.add, color: Colors.pink),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  cartController.addToCart(
                    productName,
                    productPrice * quantity,
                    productImage,
                  );
                  Get.snackbar(
                    'Added to Cart',
                    'Hydrating Serum ($quantity) has been added to your cart',
                    snackPosition: SnackPosition.TOP,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Center(
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Related Products
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Related Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Using GridView instead of ListView
            Container(
              height: 500, // Adjust height as needed
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 4, // Number of related products
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => Get.to(() => const ProductDetailsPage()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    index.isEven
                                        ? 'https://www.sephora.com/productimages/sku/s2743060-main-zoom.jpg?imwidth=1224'
                                        : 'https://www.sephora.com/productimages/product/p443563-av-1-zoom.jpg?imwidth=1224',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          // Product Details
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  index.isEven ? 'Hydrating Serum' : 'Moisturizing Cream',
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
                                      index.isEven ? '\$24.99' : '\$29.99',
                                      style: const TextStyle(
                                        color: Colors.pink,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Obx(() {
                                      final productId = 'related-product-$index';
                                      return IconButton(
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          favoriteController.isFavorite(productId)
                                              ? Iconsax.heart5
                                              : Iconsax.heart,
                                          color: favoriteController.isFavorite(productId)
                                              ? Colors.pink
                                              : Colors.grey.shade400,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          favoriteController.toggleFavorite(
                                            FavoriteProduct(
                                              id: productId,
                                              name: index.isEven ? 'Hydrating Serum' : 'Moisturizing Cream',
                                              price: index.isEven ? 24.99 : 29.99,
                                              image: index.isEven
                                                  ? 'https://www.sephora.com/productimages/sku/s2743060-main-zoom.jpg?imwidth=1224'
                                                  : 'https://www.sephora.com/productimages/product/p443563-av-1-zoom.jpg?imwidth=1224',
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
