import 'package:ecommer_skincare_app/features/cart/presentation/controllers/cart_controller.dart';
import 'package:ecommer_skincare_app/features/checkout/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
 

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Text('Your cart is empty'),
          );
        }
        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartController.cartItems[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: const Icon(Iconsax.trash),
                onPressed: () => cartController.removeFromCart(index),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total: \$${cartController.total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: cartController.cartItems.isNotEmpty
                    ? () => Get.to(() => CheckoutPage())
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text('Proceed to Checkout'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

