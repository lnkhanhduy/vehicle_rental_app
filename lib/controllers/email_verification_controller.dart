import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';

class EmailVerificationController extends GetxController {
  static EmailVerificationController get instance => Get.find();

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
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
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
