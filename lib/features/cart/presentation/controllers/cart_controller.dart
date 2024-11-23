import 'package:get/get.dart';

class CartItem {
  final String name;
  final double price;

  CartItem(this.name, this.price);
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  double get total => cartItems.fold(0, (sum, item) => sum + item.price);

  void addToCart(String name, double price) {
    cartItems.add(CartItem(name, price));
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }
}

