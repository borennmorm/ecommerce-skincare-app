import 'package:get/get.dart';

class CartItem {
  final String name;
  final double price;
  final String image;

  CartItem(this.name, this.price, this.image);
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  double get total => cartItems.fold(0, (sum, item) => sum + item.price);

  void addToCart(String name, double price, String image) {
    cartItems.add(CartItem(name, price, image));
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }
}

