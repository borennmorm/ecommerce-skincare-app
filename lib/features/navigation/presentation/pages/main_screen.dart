import 'package:ecommer_skincare_app/features/favorite/presentation/pages/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/navigation_controller.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../product/presentation/pages/product_list_page.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../cart/presentation/controllers/cart_controller.dart';
import '../../../favorite/presentation/controllers/favorite_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final NavigationController navigationController = Get.put(NavigationController());
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  final List<Widget> pages = [
    const HomePage(),
    const ProductListPage(),
    CartPage(),
    FavoritePage(), 
    const Placeholder(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => pages[navigationController.selectedIndex.value],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomAppBar(
            height: 70,
            notchMargin: 8,
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side items
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildNavItem(0, Iconsax.home, 'Home'),
                          _buildNavItem(1, Iconsax.shop, 'Products'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 80,),
                    // Right side items
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildNavItem(3, Iconsax.heart, 'Favorites'),
                          _buildNavItem(4, Iconsax.setting, 'Settings'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => SizedBox(
          width: 65,
          height: 65,
          child: FloatingActionButton(
            backgroundColor: navigationController.selectedIndex.value == 2 
                ? Colors.pink 
                : Colors.grey.shade400,
            elevation: 8,
            onPressed: () => navigationController.changePage(2),
            shape: const CircleBorder(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Icon(
                    Iconsax.shopping_cart,
                    size: 30,
                    color: navigationController.selectedIndex.value == 2 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.9),
                  ),
                ),
                Positioned(
                  right: -5,
                  top: -5,
                  child: Obx(() {
                    final itemCount = cartController.cartItems.length;
                    return itemCount > 0
                        ? Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              itemCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = navigationController.selectedIndex.value == index;
    return InkWell(
      onTap: () => navigationController.changePage(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.pink : Colors.grey.shade400,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.pink : Colors.grey.shade400,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
} 