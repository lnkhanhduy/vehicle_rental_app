import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/rental_model.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';
import 'package:vehicle_rental_app/screens/success_screen.dart';

class RentalRepository extends GetxController {
  static RentalRepository get instance => Get.find();

  final firebaseFirestore = FirebaseFirestore.instance;

  Future<List<RentalModel>?> getRentalList() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("Rentals")
        .where("isApproved", isEqualTo: false)
        .orderBy("isApproved", descending: false)
        .get();
    List<RentalModel> rentalList = querySnapshot.docs.map((doc) {
      return RentalModel.fromSnapshot(
          doc as DocumentSnapshot<Map<String, dynamic>>);
    }).toList();
    return rentalList;
  }

  Future<void> sendRequestRental(RentalModel rentalModel) async {
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
      await firebaseFirestore.collection("Rentals").doc().set({
        "carId": rentalModel.idCar,
        "email": email,
        "fromDate": rentalModel.fromDate,
        "toDate": rentalModel.toDate,
        "message": rentalModel.message,
        "idOwner": rentalModel.idOwner,
        "isApproved": false
      });

      Get.to(() => const SuccessScreen(
          title: "Gửi yêu cầu thuê xe thành công",
          content:
              "Bạn đã gửi yêu cầu thuê xe thành công. Chủ xe sẽ sớm liên hệ với bạn."));
    }
  }
}
