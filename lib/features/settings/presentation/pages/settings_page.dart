import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../../../auth/presentation/controllers/user_controller.dart';
import 'edit_profile_page.dart';
import 'notification_settings_page.dart';
import 'privacy_policy_page.dart';
import 'about_page.dart';

class SettingsPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Profile Section
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
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
                child: Row(
                  children: [
                    // Profile Picture Section
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        Iconsax.user,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Profile Info Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                            userController.userName.value,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Obx(() => Text(
                            userController.email.value,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          )),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () => Get.to(() => const EditProfilePage()),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.pink,
                              side: const BorderSide(color: Colors.pink),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Iconsax.edit_2, size: 16),
                                SizedBox(width: 4),
                                Text('Edit Profile'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          
              // Settings Options
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
                    _buildSettingItem(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      onTap: () => Get.to(() => NotificationSettingsPage()),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Iconsax.global,
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () {
                        _showLanguageDialog(context);
                      },
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Iconsax.security,
                      title: 'Privacy Policy',
                      onTap: () => Get.to(() => const PrivacyPolicyPage()),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Iconsax.info_circle,
                      title: 'About',
                      onTap: () => Get.to(() => const AboutPage()),
                    ),
                  ],
                ),
              ),
          
              // Logout Button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.red),
          
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
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

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                // Change language to English
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Khmer'),
              onTap: () {
                // Change language to Khmer
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform logout
              Get.offAll(() => const LoginScreen());
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
} 