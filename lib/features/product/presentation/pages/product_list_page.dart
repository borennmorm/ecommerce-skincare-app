import 'package:ecommer_skincare_app/features/product/widgets/product_card.dart';
import 'package:ecommer_skincare_app/features/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'product_details_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final RxString _selectedCategory = 'All'.obs;
  final RxString _selectedPriceRange = 'All'.obs;
  final RxBool _isOnSale = false.obs;
  
  final List<String> categories = [
    'All',
    'Cleansers',
    'Moisturizers',
    'Serums',
    'Masks',
  ];

  final List<String> priceRanges = [
    'All',
    'Under \$10',
    '\$10 - \$25',
    '\$25 - \$50',
    'Over \$50',
  ];

  void _showFilterBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Categories
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Obx(() => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: _selectedCategory.value == categories[index],
                      label: Text(categories[index]),
                      onSelected: (selected) {
                        _selectedCategory.value = categories[index];
                      },
                      selectedColor: Colors.pink[100],
                      checkmarkColor: Colors.pink,
                    ),
                  ));
                },
              ),
            ),
            const SizedBox(height: 20),

            // Price Range
            const Text(
              'Price Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: priceRanges.length,
                itemBuilder: (context, index) {
                  return Obx(() => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: _selectedPriceRange.value == priceRanges[index],
                      label: Text(priceRanges[index]),
                      onSelected: (selected) {
                        _selectedPriceRange.value = priceRanges[index];
                      },
                      selectedColor: Colors.pink[100],
                      checkmarkColor: Colors.pink,
                    ),
                  ));
                },
              ),
            ),
            const SizedBox(height: 20),

            // On Sale Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'On Sale',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() => Switch(
                  value: _isOnSale.value,
                  onChanged: (value) => _isOnSale.value = value,
                  activeColor: Colors.pink,
                  inactiveTrackColor: Colors.grey[300],
                  inactiveThumbColor: Colors.grey[400],
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // Add these properties for better visual feedback
                  activeTrackColor: Colors.pink[100],
                  thumbColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.pink;
                      }
                      return Colors.grey.shade400;
                    },
                  ),
                )),
              ],
            ),
            const SizedBox(height: 20),

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Apply filters and close bottom sheet
                  Get.back();
                  // Here you would typically filter your products based on the selected values
                  _applyFilters();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _applyFilters() {
    // Here you would implement the actual filtering logic
    if (_selectedCategory.value == 'All' && 
        _selectedPriceRange.value == 'All' && 
        !_isOnSale.value) {
      Get.snackbar(
        'Filters Cleared',
        'All filters have been cleared',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    String message = 'Filters Applied:\n';
    if (_selectedCategory.value != 'All') {
      message += '• Category: ${_selectedCategory.value}\n';
    }
    if (_selectedPriceRange.value != 'All') {
      message += '• Price Range: ${_selectedPriceRange.value}\n';
    }
    if (_isOnSale.value) {
      message += '• On Sale Items Only';
    }

    Get.snackbar(
      'Filters Applied',
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green[100],
      colorText: Colors.green[900],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products', style: TextStyle(fontSize: 18,),),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.search_normal),
            onPressed: () => Get.to(() => SearchPage()),
          ),
          const SizedBox(width: 10,),
          IconButton(
            icon: const Icon(Iconsax.filter),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Active Filters
          Container(
            // height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(() => Row(
                      children: [
                        if (_selectedCategory.value != 'All')
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Chip(
                              label: Text(_selectedCategory.value),
                              onDeleted: () => _selectedCategory.value = 'All',
                              backgroundColor: Colors.pink[50],
                            ),
                          ),
                        if (_selectedPriceRange.value != 'All')
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Chip(
                              label: Text(_selectedPriceRange.value),
                              onDeleted: () => _selectedPriceRange.value = 'All',
                              backgroundColor: Colors.pink[50],
                            ),
                          ),
                        if (_isOnSale.value)
                          Chip(
                            label: const Text('On Sale'),
                            onDeleted: () => _isOnSale.value = false,
                            backgroundColor: Colors.pink[50],
                          ),
                      ],
                    )),
                  ),
                ),
                if (_selectedCategory.value != 'All' || 
                    _selectedPriceRange.value != 'All' || 
                    _isOnSale.value)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory.value = 'All';
                        _selectedPriceRange.value = 'All';
                        _isOnSale.value = false;
                      });
                      Get.snackbar(
                        'Filters Cleared',
                        'All filters have been cleared',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.blue[100],
                        colorText: Colors.blue[900],
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.pink,
                    ),
                    child: const Text('Clear All'),
                  ),
              ],
            ),
          ),

          // Product Grid
          Expanded(
            child: GridView.builder(
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
          ),
          const SizedBox(height: 20,),
        ],
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
