import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';

class EmailVerificationController extends GetxController {
  late Timer timer;

  final firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
  }

  Future<bool> sendVerificationEmail() async {
    try {
      await firebaseAuth.currentUser?.sendEmailVerification();
      return true;
    } on FirebaseAuthException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> manuallyCheckEmailVerificationStatus() async {
   await firebaseAuth.currentUser?.reload();
    if (firebaseAuth.currentUser?.emailVerified == true) {
      Get.to(() => const LayoutScreen(initialIndex: 0));
    }
  }
}
