import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/authentication_repository.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final address = TextEditingController();

  final _authRepos = Get.put(AuthenticationRepository());
  final _userRepos = Get.put(UserRepository());

  Future<UserModel?> getUserData() async {
    final email = _authRepos.firebaseUser.value?.email;
    if (email != null) {
      return await _userRepos.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Something went wrong. Try again");
      return null;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _userRepos.updateUser(user);
      Get.snackbar("Success", "Cập nhật thành công");
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Try again");
    }
  }
}
