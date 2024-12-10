import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../home/presentation/pages/home_page.dart';
import '../pages/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String username, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally, update the display name with the username
      await userCredential.user?.updateDisplayName(username);

      Get.snackbar("Success", "Account created successfully!",
          snackPosition: SnackPosition.BOTTOM);

      // Navigate to HomePage or LoginScreen
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Logged in successfully!',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => const HomePage());
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
