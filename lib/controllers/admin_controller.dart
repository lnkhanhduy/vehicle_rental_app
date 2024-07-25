import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

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

  Future<bool> approveCar(String id) async {
    try {
      await firebaseFirestore
          .collection("Cars")
          .doc(id)
          .update({"isApproved": true, "message": ""});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelCar(String id, String message) async {
    try {
      await firebaseFirestore
          .collection("Cars")
          .doc(id)
          .update({"isApproved": false, "message": message});

      return true;
    } catch (e) {
      return false;
    }
  }

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

  Future<bool> approveUser(String id) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(id)
          .update({"isVerified": true, "message": ""});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelUser(String id, String message) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(id)
          .update({"isVerified": false, "message": message});

      return true;
    } catch (e) {
      return false;
    }
  }
}
