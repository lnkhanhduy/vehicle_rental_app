import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final username = TextEditingController();
  final password = TextEditingController();

  final userRepository = UserRepository.instance;

  Future<void> loginUser(String username, String password) async {
    await userRepository.loginUser(username, password);
  }

  Future<void> googleSignIn() async {
    await userRepository.signInWithGoogle();
  }
}
