import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var username = ''.obs;

  void login(String email, String password) {
    // In a real app, you would validate credentials against a backend
    // For this example, we'll just set a dummy username and log in
    username.value = email.split('@')[0];
    isLoggedIn.value = true;
    Get.offAllNamed('/');
  }

  void register(String username, String email, String password) {
    // In a real app, you would send registration data to a backend
    // For this example, we'll just log in the user after registration
    login(email, password);
  }

  void logout() {
    isLoggedIn.value = false;
    username.value = '';
    Get.offAllNamed('/auth');
  }
}

