import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/rental_model.dart';
import 'package:vehicle_rental_app/models/rental_user_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/success_screen.dart';

class RentalController extends GetxController {
  static RentalController get instance => Get.find();

  final userController = Get.put(UserController());

  final firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> sendRequestRental(RentalModel rentalModel) async {
    final email = userController.firebaseUser.value?.providerData[0].email;
    if (email == null) {
      return false;
    } else {
      try {
        await firebaseFirestore.collection("Rentals").doc().set({
          "email": email,
          "idOwner": rentalModel.idOwner,
          "idCar": rentalModel.idCar,
          "fromDate": rentalModel.fromDate,
          "toDate": rentalModel.toDate,
          "message": rentalModel.message,
          "status": "waiting"
        });
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  Future<bool> approveRequest(
      String idRental, String idUserRental, String idCar) async {
    try {
      await firebaseFirestore
          .collection("Rentals")
          .doc(idRental)
          .update({"status": "approved"});

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

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelRequest(String idRental) async {
    try {
      await firebaseFirestore
          .collection("Rentals")
          .doc(idRental)
          .update({"status": "rejected"});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelRequestByUser(
      String idRental, String idCar, String email) async {
    try {
      await firebaseFirestore
          .collection("Rentals")
          .doc(idRental)
          .update({"status": "canceled"});

      await firebaseFirestore.collection("Cars").doc(idCar).update({
        "isRented": false,
      });

      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("Users")
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        await firebaseFirestore.collection("Users").doc(userDoc.id).update({
          'isRented': false,
        });
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> ratingRental(String idRental, String idUserRental, String idCar,
      int star, String review) async {
    try {
      await firebaseFirestore.collection("Rentals").doc(idRental).update({
        "status": "paid",
        "star": star,
        "review": review,
        "reviewDate": DateTime.now().toString()
      });

      DocumentSnapshot<Map<String, dynamic>> carModel =
          await firebaseFirestore.collection("Cars").doc(idCar).get();

      if (carModel.data() != null) {
        await firebaseFirestore.collection("Cars").doc(idCar).update({
          "isRented": false,
          "totalRental": carModel.data()!["totalRental"] + 1,
          "star": carModel.data()!["star"] + star
        });
      }

      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("Users")
          .where('email', isEqualTo: idUserRental)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;

        if (userData != null) {
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(userDoc.id)
              .update({
            'isRented': false,
            "totalRental": userData["totalRental"] + 1,
            "star": userData["star"] + star
          });
        }
      }

      Get.to(() => const SuccessScreen(
          title: "Đánh giá thành công",
          content: "Bạn đã đánh giá thuê xe thành công."));
    } catch (e) {
      return;
    }
  }

  Future<List<RentalUserModel>?> getListRentalModelByCar(String idCar) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("Rentals")
          .where('idCar', isEqualTo: idCar)
          .where('status', isEqualTo: 'paid')
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      List<RentalModel> rentalList = querySnapshot.docs.map((doc) {
        return RentalModel.fromSnapshot(
          doc as DocumentSnapshot<Map<String, dynamic>>,
        );
      }).toList();

      List<RentalUserModel> rentalUserModelList = [];
      for (var rental in rentalList) {
        final userDoc =
            await firebaseFirestore.collection("Users").doc(rental.email).get();

        if (userDoc.exists) {
          rentalUserModelList.add(
            RentalUserModel(
              rentalModel: rental,
              userModel: UserModel.fromSnapshot(userDoc),
            ),
          );
        }
      }

      return rentalUserModelList;
    } catch (e) {
      return null;
    }
  }
}
