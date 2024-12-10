import 'package:ecommer_skincare_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ecommer_skincare_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscured = true;

  void register() {
  if (usernameController.text.isEmpty ||
      emailController.text.isEmpty ||
      passwordController.text.isEmpty) {
    Get.snackbar('Error', 'All fields are required!',
        snackPosition: SnackPosition.BOTTOM);
    return;
  }

  authController.register(
    usernameController.text,
    emailController.text,
    passwordController.text,
  );
}


  @override
  Widget build(BuildContext context) {
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
                  'Create an account to continue.',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Username TextField
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16),
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
                        _isObscured ? Icons.visibility_off : Icons.visibility,
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
                const SizedBox(height: 16),
                // Register Button
                ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Add Google Sign-In functionality here
                  },
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
                    Get.offAll(() => const LoginScreen());
                  },
                  child: const Text('Already have an account? Login!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
