import 'package:get/get.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';

class LicenseController extends GetxController {
  static LicenseController get instance => Get.find();

  final userRepository = UserRepository.instance;
}
