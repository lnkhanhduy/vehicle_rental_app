import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/authentication_repository.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  final userRepos = Get.put(UserRepository());

  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  void phoneAuthentication(String phone) {
    AuthenticationRepository.instance.phoneAuthentication(phone);
  }

  Future<void> createUser(UserModel user) async {
    await userRepos.createUser(user);
  }
}
