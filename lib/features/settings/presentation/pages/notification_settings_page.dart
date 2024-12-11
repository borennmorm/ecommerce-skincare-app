import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NotificationSettingsPage extends StatelessWidget {
  NotificationSettingsPage({super.key});

  final RxBool _pushNotifications = true.obs;
  final RxBool _emailNotifications = true.obs;
  final RxBool _orderUpdates = true.obs;
  final RxBool _promotions = false.obs;
  final RxBool _newArrivals = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontSize: 18),),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
              child: Column(
                children: [
                  _buildNotificationItem(
                    'Push Notifications',
                    'Receive push notifications on your device',
                    _pushNotifications,
                    Iconsax.notification,
                  ),
                  _buildDivider(),
                  _buildNotificationItem(
                    'Email Notifications',
                    'Receive updates via email',
                    _emailNotifications,
                    Iconsax.sms,
                  ),
                  _buildDivider(),
                  _buildNotificationItem(
                    'Order Updates',
                    'Get notified about your order status',
                    _orderUpdates,
                    Iconsax.box,
                  ),
                  _buildDivider(),
                  _buildNotificationItem(
                    'Promotions & Offers',
                    'Stay updated with latest deals',
                    _promotions,
                    Iconsax.discount_shape,
                  ),
                  _buildDivider(),
                  _buildNotificationItem(
                    'New Arrivals',
                    'Get notified about new products',
                    _newArrivals,
                    Iconsax.shop,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'You can manage your notification preferences here. These settings affect how you receive updates about your orders, promotions, and other activities.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String subtitle,
    RxBool value,
    IconData icon,
  ) {
    return ListTile(
      leading: Obx(() => Icon(
        icon, 
        color: value.value ? Colors.pink : Colors.grey,
      )),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      trailing: Obx(
        () => Switch(
          value: value.value,
          onChanged: (newValue) => value.value = newValue,
          activeColor: Colors.pink,
          inactiveTrackColor: Colors.grey[300],
          inactiveThumbColor: Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[200],
      indent: 16,
      endIndent: 16,
    );
  }
} 