import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/car_repository.dart';

class CarController extends GetxController {
  static CarController get instance => Get.find();

  final carRepository = CarRepository.instance;

  Future<void> registerCar(
      CarModel carModel,
      Uint8List imageCarMain,
      Uint8List imageCarInside,
      Uint8List imageCarFront,
      Uint8List imageCarBack,
      Uint8List imageCarLeft,
      Uint8List imageCarRight,
      Uint8List imageRegistrationCertificate,
      Uint8List imageCarInsurance,
      String price) async {
    await carRepository.registerCar(
        carModel,
        imageCarMain,
        imageCarInside,
        imageCarFront,
        imageCarBack,
        imageCarLeft,
        imageCarRight,
        imageRegistrationCertificate,
        imageCarInsurance,
        price);
  }

  Future<void> updateCar(
      CarModel carModel,
      Uint8List? imageCarMain,
      Uint8List? imageCarInside,
      Uint8List? imageCarFront,
      Uint8List? imageCarBack,
      Uint8List? imageCarLeft,
      Uint8List? imageCarRight,
      Uint8List? imageRegistrationCertificate,
      Uint8List? imageCarInsurance,
      String price) async {
    await carRepository.updateCar(
        carModel,
        imageCarMain,
        imageCarInside,
        imageCarFront,
        imageCarBack,
        imageCarLeft,
        imageCarRight,
        imageRegistrationCertificate,
        imageCarInsurance,
        price);
  }

  Future<List<CarModel>?> getCarApprove() async {
    return await carRepository.getCarApprove();
  }

  Future<UserModel?> getUserCar(String email) async {
    return await carRepository.getUserCar(email);
  }

  Future<void> approveCar(String id) async {
    await carRepository.approveCar(id);
  }

  Future<void> cancelCar(String id, String message) async {
    await carRepository.cancelCar(id, message);
  }
}
