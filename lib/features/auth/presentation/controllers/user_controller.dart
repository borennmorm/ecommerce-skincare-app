import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Rx<User?> user = Rx<User?>(null);
  final RxString userName = ''.obs;
  final RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
    if (user.value != null) {
      fetchUserData();
    }
  }

  Future<void> fetchUserData() async {
    try {
      if (user.value != null) {
        final userData = await _firestore
            .collection('users')
            .doc(user.value!.uid)
            .get();

        if (userData.exists) {
          userName.value = userData.data()?['name'] ?? 'No Name';
          email.value = userData.data()?['email'] ?? user.value!.email ?? 'No Email';
        } else {
          // Create user document if it doesn't exist
          await _firestore.collection('users').doc(user.value!.uid).set({
            'name': user.value!.displayName ?? 'No Name',
            'email': user.value!.email ?? 'No Email',
          });
          userName.value = user.value!.displayName ?? 'No Name';
          email.value = user.value!.email ?? 'No Email';
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch user data',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> updateProfile({
    String? name,
    String? newEmail,
  }) async {
    try {
      if (user.value == null) return;

      final updates = <String, dynamic>{};
      
      if (name != null && name.isNotEmpty) {
        updates['name'] = name;
        userName.value = name;
      }

      if (newEmail != null && newEmail.isNotEmpty && newEmail != user.value!.email) {
        await user.value!.updateEmail(newEmail);
        updates['email'] = newEmail;
        email.value = newEmail;
      }

      if (updates.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(user.value!.uid)
            .update(updates);
        
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar(
        'Error',
        'Failed to update profile: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
} 