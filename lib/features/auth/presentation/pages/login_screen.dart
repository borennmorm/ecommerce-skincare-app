import 'package:ecommer_skincare_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'forget_password.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscured = true;

  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Email and Password cannot be empty!',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    authController.login(emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signOut();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                // App Logo
                Image.asset(
                  'assets/images/cosmetics.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                // App Title
                const Text(
                  'SkincareCo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Subtitle
                const Text(
                  'Welcome back! You\'ve been missed.',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Email TextField
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                // Password TextField
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Iconsax.eye_slash : Iconsax.eye,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscured,
                ),
                // Forget password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(() => const ForgetPassword());
                    },
                    child: const Text('Forget password?'),
                  ),
                ),
                // Login Button
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Sign In With Google',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Spacer replacement
                TextButton(
                  onPressed: () {
                    Get.offAll(() => const RegisterScreen());
                  },
                  child: const Text('Don\'t have an account yet? Register!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
