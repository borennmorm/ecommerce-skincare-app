import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'Information Collection',
                    'We collect information that you provide directly to us, including your name, email address, and any other information you choose to provide.',
                    Iconsax.document,
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Data Usage',
                    'We use the information we collect to provide, maintain, and improve our services, to process your transactions, and to communicate with you.',
                    Iconsax.data,
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Data Protection',
                    'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
                    Iconsax.security,
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Third-Party Services',
                    'We may share your information with third-party service providers to facilitate our services, but we require these parties to maintain confidentiality.',
                    Iconsax.share,
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Your Rights',
                    'You have the right to access, update, or delete your personal information at any time through your account settings.',
                    Iconsax.user,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Last updated: ${DateTime.now().year}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.pink),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }
} 