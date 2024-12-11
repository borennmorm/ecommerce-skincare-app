import 'package:ecommer_skincare_app/features/navigation/presentation/pages/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String username, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
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
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Logged in successfully!',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => MainScreen()); // Navigate to the Home page
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Success',
        'Password reset email has been sent!',
        snackPosition: SnackPosition.TOP,
      );
      Get.to(() => const LoginScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send password reset email: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.snackbar('Error', 'Google Sign-In cancelled by user.',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.snackbar('Success', 'Logged in with Google',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
