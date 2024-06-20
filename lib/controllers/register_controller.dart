import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final userRepos = Get.put(UserRepository());

  Future<void> createUser(UserModel user) async {
    await userRepos.createUser(user);
  }
}
