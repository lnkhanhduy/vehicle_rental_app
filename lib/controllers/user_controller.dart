import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  Future<void> loginUser(String username, String password) async {
    await userRepository.loginUser(username, password);
  }

  Future<void> googleSignIn() async {
    await userRepository.signInWithGoogle();
  }

  Future<void> createUser(UserModel user) async {
    await userRepository.createUser(user);
  }

  Future<void> forgotPassword(String email) async {
    await userRepository.forgotPassword(email);
  }

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

  Future<void> updateUserWithImage(
      UserModel user, Uint8List imageAvatar) async {
    await userRepository.updateUserWithImage(user, imageAvatar);
  }

  Future<void> updatePaper(
      Uint8List? imageIdCardFront,
      Uint8List? imageIdCardBack,
      Uint8List? imageLicenseFront,
      Uint8List? imageLicenseBack) async {
    await userRepository.updatePaper(
        imageIdCardFront, imageIdCardBack, imageLicenseFront, imageLicenseBack);
  }

  Future<List<UserModel>?> getUserApprove() async {
    return await userRepository.getUserApprove();
  }

  Future<void> approveUser(String id) async {
    await userRepository.approveUser(id);
  }

  Future<void> cancelUser(String id, String message) async {
    await userRepository.cancelUser(id, message);
  }
}
