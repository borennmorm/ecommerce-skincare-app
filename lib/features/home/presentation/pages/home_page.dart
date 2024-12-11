import 'package:ecommer_skincare_app/features/cart/presentation/pages/cart_page.dart';
import 'package:ecommer_skincare_app/features/product/presentation/pages/product_details_page.dart';
import 'package:ecommer_skincare_app/features/product/presentation/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:iconsax/iconsax.dart';
import 'package:ecommer_skincare_app/features/search/presentation/pages/search_page.dart';
import 'package:ecommer_skincare_app/features/product/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> bannerImages = const [
    'https://t3.ftcdn.net/jpg/02/28/47/78/360_F_228477803_rvOdKapC3wLKWl8tYaYmvQOLXcxFYD3G.jpg',
    'https://t4.ftcdn.net/jpg/03/72/21/29/360_F_372212921_l0wtrUbGY168QTCIRHp1W02ug8CVuWSV.jpg',
    'https://static.vecteezy.com/system/resources/previews/023/549/611/non_2x/items-and-accessories-for-face-and-body-skin-care-relaxation-burning-candles-spa-stones-oil-serum-eye-mask-for-sleeping-cream-towel-bathrobe-banner-with-space-for-text-illustration-vector.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/023/549/610/small_2x/glass-bottle-with-oil-serum-in-a-wooden-bowl-surrounded-by-green-leaves-health-and-beauty-top-view-skin-care-banner-massage-time-illustration-vector.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SkincareCo'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.search_normal),
            onPressed: () => Get.to(() => SearchPage()),
          ),
          
        ],
      ),
      backgroundColor: Colors.grey[100],

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            _buildCategorySection(),
            _buildFeaturedProducts(),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: bannerImages.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(bannerImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    const Center(
                      child: Text(
                        'Discover Your Perfect Skincare Routine',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bannerImages.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == entry.key 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    final categories = ['Cleansers', 'Moisturizers', 'Serums', 'Masks'];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40, // Fixed height for the horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Chip(
                    label: Text(
                      categories[index],
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    backgroundColor: Colors.pink[100],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Products',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildProductCard();
            },
          ),
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
