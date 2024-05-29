import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> loginUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .loginUserWithEmailAndPassword(email, password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }
}
