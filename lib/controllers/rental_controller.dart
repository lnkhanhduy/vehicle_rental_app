import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/rental_model.dart';
import 'package:vehicle_rental_app/screens/success_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/request_rental_car_screen.dart';

class RentalController extends GetxController {
  static RentalController get instance => Get.find();

  final userController = UserController.instance;

  final firebaseFirestore = FirebaseFirestore.instance;

  // Future<List<RentalModel>?> getRentalList() async {
  //   QuerySnapshot querySnapshot = await firebaseFirestore
  //       .collection("Rentals")
  //       .where("isApproved", isEqualTo: false)
  //       .where("isResponsed", isEqualTo: false)
  //       .where("isCanceled", isEqualTo: false)
  //       .orderBy("isApproved", descending: false)
  //       .get();
  //   List<RentalModel> rentalList = querySnapshot.docs.map((doc) {
  //     return RentalModel.fromSnapshot(
  //         doc as DocumentSnapshot<Map<String, dynamic>>);
  //   }).toList();
  //   return rentalList;
  // }

  Future<void> sendRequestRental(RentalModel rentalModel) async {
    final email = userController.firebaseUser.value?.providerData[0].email;
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
        "idCar": rentalModel.idCar,
        "email": email,
        "fromDate": rentalModel.fromDate,
        "toDate": rentalModel.toDate,
        "message": rentalModel.message,
        "idOwner": rentalModel.idOwner,
        "isCanceled": false,
        "isApproved": false,
        "isResponsed": false,
      });

      Get.to(() => const SuccessScreen(
          title: "Gửi yêu cầu thuê xe thành công",
          content:
              "Bạn đã gửi yêu cầu thuê xe thành công. Chủ xe sẽ sớm liên hệ với bạn."));
    }
  }

  Future<void> approveRequest(
      String idRental, String idUserRental, String idCar) async {
    await firebaseFirestore
        .collection("Rentals")
        .doc(idRental)
        .update({"isApproved": true, "isResponsed": true});

    await firebaseFirestore.collection("Cars").doc(idCar).update({
      "isRented": true,
    });

    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("Users")
        .where('email', isEqualTo: idUserRental)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = querySnapshot.docs.first;
      await firebaseFirestore.collection("Users").doc(userDoc.id).update({
        'isRented': true,
      });
    }

    Get.to(() => const SuccessScreen(
        title: "Chấp nhận cho thuê xe thành công",
        content:
            "Chấp nhận cho thuê xe thành công. Người thuê sẽ sớm đến lấy xe."));
  }

  Future<void> cancelRequest(String idRental) async {
    await firebaseFirestore
        .collection("Rentals")
        .doc(idRental)
        .update({"isApproved": false, "isResponsed": true});

    Get.to(() => const RequestRentalCarScreen());
  }

  Future<void> cancelRequestByUser(String idRental) async {
    await firebaseFirestore
        .collection("Rentals")
        .doc(idRental)
        .update({"isCanceled": true});

    Get.closeCurrentSnackbar();
    Get.showSnackbar(GetSnackBar(
      messageText: const Text(
        "Bạn đã hủy thuê xe thành công!",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check, color: Colors.white),
      onTap: (_) {
        Get.closeCurrentSnackbar();
      },
    ));
  }
}
