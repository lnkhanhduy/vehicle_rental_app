import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/repository/authentication_repository.dart';
import 'package:vehicle_rental_app/screens/home_screen.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeScreen()) : Get.back();
  }
}
