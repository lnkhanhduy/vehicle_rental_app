import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final address = TextEditingController();

  final userRepository = Get.put(UserRepository());

  Future<UserModel?> getUserData() async {
    final email = userRepository.firebaseUser.value?.providerData[0].email;
    if (email != null) {
      return await userRepository.getUserDetails(email);
    } else {
      Get.closeCurrentSnackbar();
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          "Có lỗi xảy ra. Vui lòng thử lại sau!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
        icon: const Icon(Icons.error, color: Colors.white),
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ));
      return null;
    }
  }

  Future<void> changePassword(String password, String confirmPassword) async {
    await userRepository.changePassword(password, confirmPassword);
  }

  Future<void> updateUser(UserModel user) async {
    await userRepository.updateUser(user);
  }

  Future<void> updateLicense(
      String typeLicense, Uint8List? imageFront, Uint8List? imageBack) async {
    await userRepository.updateLicense(typeLicense, imageFront, imageBack);
  }

  Future<void> updateIdCard(Uint8List? imageFront, Uint8List? imageBack) async {
    await userRepository.updateIdCard(imageFront, imageBack);
  }
}
