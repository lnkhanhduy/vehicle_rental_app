import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/admin/approve_car_screen.dart';
import 'package:vehicle_rental_app/screens/admin/approve_user_paper_screen.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<List<UserModel>?> getUserApproveScreen() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("Users")
          .where("isAdmin", isEqualTo: false)
          .orderBy("isVerified", descending: false)
          .get();

      List<UserModel> userList = querySnapshot.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['imageIdCardFront'] != null &&
            data['imageIdCardBack'] != null &&
            data['imageLicenseFront'] != null &&
            data['imageLicenseBack'] != null;
      }).map((doc) {
        return UserModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();

      return userList;
    } catch (e) {
      return null;
    }
  }

  Future<void> approveUser(String id) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(id)
          .update({"isVerified": true, "message": ""});
      Get.to(() => const ApproveUserPaperScreen());
    } catch (e) {
      return;
    }
  }

  Future<void> cancelUser(String id, String message) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(id)
          .update({"isVerified": false, "message": message});
      Get.to(() => const ApproveUserPaperScreen());
    } catch (e) {
      return;
    }
  }

  Future<List<CarModel>?> getCarApproveScreen() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("Cars")
          .orderBy("isApproved", descending: false)
          .get();

      List<CarModel> carList = querySnapshot.docs.map((doc) {
        return CarModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();

      return carList;
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
      Get.to(() => const ApproveCarScreen());
    } catch (e) {
      return;
    }
  }

  Future<void> cancelCar(String id, String message) async {
    try {
      await firebaseFirestore
          .collection("Cars")
          .doc(id)
          .update({"isApproved": false, "message": message});
      Get.to(() => const ApproveCarScreen());
    } catch (e) {
      return;
    }
  }
}
