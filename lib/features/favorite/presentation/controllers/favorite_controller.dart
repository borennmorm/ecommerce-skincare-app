import 'package:get/get.dart';

class FavoriteProduct {
  final String id;
  final String name;
  final double price;
  final String image;

  FavoriteProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}

class FavoriteController extends GetxController {
  final RxList<FavoriteProduct> favoriteItems = <FavoriteProduct>[].obs;
  final RxSet<String> favoriteIds = <String>{}.obs;

  void toggleFavorite(FavoriteProduct product) {
    if (favoriteIds.contains(product.id)) {
      favoriteIds.remove(product.id);
      favoriteItems.removeWhere((item) => item.id == product.id);
    } else {
      favoriteIds.add(product.id);
      favoriteItems.add(product);
    }
  }

  bool isFavorite(String productId) {
    return favoriteIds.contains(productId);
  }
} 