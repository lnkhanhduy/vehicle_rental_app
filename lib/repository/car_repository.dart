import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';
import 'package:vehicle_rental_app/screens/car/approve_screen.dart';
import 'package:vehicle_rental_app/screens/success_screen.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class CarRepository extends GetxController {
  static CarRepository get instance => Get.find();

  final firebaseFirestore = FirebaseFirestore.instance;

  Future<void> registerCar(
      bool update,
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
    final email =
        UserRepository.instance.firebaseUser.value?.providerData[0].email;
    if (email == null) {
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
    } else {
      DocumentReference documentReference =
          await firebaseFirestore.collection("Cars").add(carModel.toJson());

      await firebaseFirestore
          .collection("Cars")
          .doc(documentReference.id)
          .update({"email": email, "price": price});

      await Utils.uploadImage(
          imageCarMain, "cars", documentReference.id, "imageCarMain", "Cars");
      await Utils.uploadImage(imageCarInside, "cars", documentReference.id,
          "imageCarInside", "Cars");
      await Utils.uploadImage(
          imageCarFront, "cars", documentReference.id, "imageCarFront", "Cars");
      await Utils.uploadImage(
          imageCarBack, "cars", documentReference.id, "imageCarBack", "Cars");
      await Utils.uploadImage(
          imageCarLeft, "cars", documentReference.id, "imageCarLeft", "Cars");
      await Utils.uploadImage(
          imageCarRight, "cars", documentReference.id, "imageCarRight", "Cars");
      await Utils.uploadImage(imageRegistrationCertificate, "cars",
          documentReference.id, "imageRegistrationCertificate", "Cars");
      await Utils.uploadImage(imageCarInsurance, "cars", documentReference.id,
          "imageCarInsurance", "Cars");

      Get.to(() => const SuccessScreen(
            title: "Đăng ký cho thuê xe thành công!",
            content:
                "Bạn đã đăng ký cho thuê xe thành công! Vui lòng chờ quản trị viên kiểm tra thông tin xe của bạn.",
          ));
    }
  }

  Future<List<CarModel>?> getCarApprove() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("Cars")
        .orderBy("isApproved", descending: false)
        .get();

    List<CarModel> carList = querySnapshot.docs.map((doc) {
      return CarModel.fromSnapshot(
          doc as DocumentSnapshot<Map<String, dynamic>>);
    }).toList();
    carList = List.generate(100, (index) {
      // Repeat each car 100 times
      return carList[index % carList.length];
    });
    return carList;
  }

  Future<UserModel?> getUserCar(String email) async {
    try {
      final snapshot = await firebaseFirestore
          .collection("Users")
          .where("email", isEqualTo: email)
          .get();
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } catch (e) {
      return null;
    }
  }

  Future<void> approveCar(String id) async {
    try {
      await firebaseFirestore
          .collection("Cars")
          .doc(id)
          .update({"isApproved": true, "message": ""});
      Get.to(() => ApproveScreen());
    } catch (e) {
      return null;
    }
  }

  Future<void> cancelCar(String id, String message) async {
    try {
      await firebaseFirestore
          .collection("Cars")
          .doc(id)
          .update({"isApproved": false, "message": message});
      Get.to(() => ApproveScreen());
    } catch (e) {
      return null;
    }
  }
}
