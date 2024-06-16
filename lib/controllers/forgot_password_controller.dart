import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  final email = TextEditingController();

  final userRepository = UserRepository.instance;

  Future<void> forgotPassword() async {
    await userRepository.forgotPassword(email.text.trim());
  }
}
