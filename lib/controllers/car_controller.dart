import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/success_screen.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class CarController extends GetxController {
  static CarController get instance => Get.find();

  final userController = UserController.instance;

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

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
      try {
        DocumentReference documentReference =
            await firebaseFirestore.collection("Cars").add(carModel.toJson());

        await firebaseFirestore
            .collection("Cars")
            .doc(documentReference.id)
            .update({
          "email": email,
          "price": price,
          "isHidden": false,
          "isRented": false
        });

        await Utils.uploadImage(
            imageCarMain, "cars", documentReference.id, "imageCarMain", "Cars");
        await Utils.uploadImage(imageCarInside, "cars", documentReference.id,
            "imageCarInside", "Cars");
        await Utils.uploadImage(imageCarFront, "cars", documentReference.id,
            "imageCarFront", "Cars");
        await Utils.uploadImage(
            imageCarBack, "cars", documentReference.id, "imageCarBack", "Cars");
        await Utils.uploadImage(
            imageCarLeft, "cars", documentReference.id, "imageCarLeft", "Cars");
        await Utils.uploadImage(imageCarRight, "cars", documentReference.id,
            "imageCarRight", "Cars");
        await Utils.uploadImage(imageRegistrationCertificate, "cars",
            documentReference.id, "imageRegistrationCertificate", "Cars");
        await Utils.uploadImage(imageCarInsurance, "cars", documentReference.id,
            "imageCarInsurance", "Cars");

        Get.to(() => const SuccessScreen(
              title: "Đăng ký cho thuê xe thành công!",
              content:
                  "Bạn đã đăng ký cho thuê xe thành công! Vui lòng chờ quản trị viên kiểm tra thông tin xe của bạn.",
            ));
      } catch (e) {
        return;
      }
    }
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
      try {
        final car =
            await firebaseFirestore.collection("Cars").doc(carModel.id).get();

        await firebaseFirestore
            .collection("Cars")
            .doc(car.id)
            .update({"price": price, "isApproved": false, "message": ""});

        if (car.exists) {
          if (imageCarMain != null) {
            await Utils.uploadImage(
                imageCarMain, "cars", carModel.id, "imageCarMain", "Cars");
            if (carModel.imageCarMain != null) {
              await Utils.deleteImageIfExists(carModel.imageCarMain!);
            }
          }
          if (imageCarInside != null) {
            await Utils.uploadImage(
                imageCarInside, "cars", carModel.id, "imageCarInside", "Cars");
            if (carModel.imageCarInside != null) {
              await Utils.deleteImageIfExists(carModel.imageCarInside!);
            }
          }

          if (imageCarFront != null) {
            await Utils.uploadImage(
                imageCarFront, "cars", carModel.id, "imageCarFront", "Cars");
            if (carModel.imageCarFront != null) {
              await Utils.deleteImageIfExists(carModel.imageCarFront!);
            }
          }
          if (imageCarBack != null) {
            await Utils.uploadImage(
                imageCarBack, "cars", carModel.id, "imageCarBack", "Cars");
            if (carModel.imageCarBack != null) {
              await Utils.deleteImageIfExists(carModel.imageCarBack!);
            }
          }
          if (imageCarLeft != null) {
            await Utils.uploadImage(
                imageCarLeft, "cars", carModel.id, "imageCarLeft", "Cars");
            if (carModel.imageCarLeft != null) {
              await Utils.deleteImageIfExists(carModel.imageCarLeft!);
            }
          }
          if (imageCarRight != null) {
            await Utils.uploadImage(
                imageCarRight, "cars", carModel.id, "imageCarRight", "Cars");
            if (carModel.imageCarRight != null) {
              await Utils.deleteImageIfExists(carModel.imageCarRight!);
            }
          }
          if (imageRegistrationCertificate != null) {
            await Utils.uploadImage(imageRegistrationCertificate, "cars",
                carModel.id, "imageRegistrationCertificate", "Cars");
            if (carModel.imageRegistrationCertificate != null) {
              await Utils.deleteImageIfExists(
                  carModel.imageRegistrationCertificate!);
            }
          }
          if (imageCarInsurance != null) {
            await Utils.uploadImage(imageCarInsurance, "cars", carModel.id,
                "imageCarInsurance", "Cars");
            if (carModel.imageCarInsurance != null) {
              await Utils.deleteImageIfExists(carModel.imageCarInsurance!);
            }
          }
        }

        Get.to(() => const SuccessScreen(
              title: "Cập nhật thông tin xe thành công!",
              content:
                  "Bạn đã cập nhật thông tin xe thành công! Vui lòng chờ quản trị viên kiểm tra thông tin xe của bạn.",
            ));
      } catch (e) {
        return;
      }
    }
  }

  Future<List<CarModel>?> getCarHomeScreen() async {
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
      try {
        UserModel? userModel =
            await UserController.instance.getUserByUsername(email);

        QuerySnapshot querySnapshot = await firebaseFirestore
            .collection("Cars")
            .where("isApproved", isEqualTo: true)
            .where("isRented", isEqualTo: false)
            .where("isHidden", isEqualTo: false)
            .where("email", isNotEqualTo: email)
            .orderBy("isApproved", descending: true)
            .get();

        final listFavorite =
            await firebaseFirestore.collection("Favorites").doc(email).get();
        List<dynamic> favoriteIds = listFavorite.data()?["listFavorite"] ?? [];

        List<CarModel> carList = querySnapshot.docs.map((doc) {
          final isFavorite = favoriteIds.contains(doc.id);
          return CarModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>,
            isFavorite: isFavorite,
          );
        }).toList();

        if (carList.length > 10 && userModel!.address != null) {
          List<CarModel> listCarAddress = carList
              .where((car) => car.address.contains(userModel.address!))
              .toList();

          while (listCarAddress.length < 10) {
            listCarAddress.addAll(carList.take(10 - listCarAddress.length));
          }

          return listCarAddress;
        } else {
          return carList;
        }
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> changeStatusCar(String idCar, bool status) async {
    try {
      await firebaseFirestore.collection("Cars").doc(idCar).update({
        "isHidden": status,
      });

      if (status) {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: const Text(
            "Đã ẩn xe!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.check, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      } else {
        Get.closeCurrentSnackbar();
        Get.showSnackbar(GetSnackBar(
          messageText: const Text(
            "Đã hiển thị xe!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.check, color: Colors.white),
          onTap: (_) {
            Get.closeCurrentSnackbar();
          },
        ));
      }
    } catch (e) {
      return;
    }
  }

  Future<List<CarModel>?> getMoreCar(String? keyword, String? priceFrom,
      String? priceTo, String? companyCar, String? transmission) async {
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
      try {
        QuerySnapshot querySnapshot = await firebaseFirestore
            .collection("Cars")
            .where("isApproved", isEqualTo: true)
            .where("isRented", isEqualTo: false)
            .where("isHidden", isEqualTo: false)
            .where("email", isNotEqualTo: email)
            .get();

        final listFavorite =
            await firebaseFirestore.collection("Favorites").doc(email).get();
        List<dynamic> favoriteIds = listFavorite.data()?["listFavorite"] ?? [];

        List<CarModel> carList = querySnapshot.docs.map((doc) {
          final isFavorite = favoriteIds.contains(doc.id);
          return CarModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>,
            isFavorite: isFavorite,
          );
        }).toList();

        if (keyword != null && keyword.isNotEmpty) {
          carList = carList
              .where((car) =>
                  car.carCompany.contains(keyword) ||
                  car.carInfoModel.contains(keyword) ||
                  car.address.contains(keyword) ||
                  keyword.contains(car.carCompany) ||
                  keyword.contains(car.address) ||
                  keyword.contains(car.carInfoModel))
              .toList();
        }

        if (priceFrom != null &&
            priceFrom.isNotEmpty &&
            priceTo != null &&
            priceTo.isNotEmpty &&
            double.parse(priceFrom) < double.parse(priceTo)) {
          carList = carList
              .where(
                  (car) => double.parse(car.price!) >= double.parse(priceFrom))
              .where((car) => double.parse(car.price!) <= double.parse(priceTo))
              .toList();
        }

        if (companyCar != null &&
            companyCar.isNotEmpty &&
            companyCar != 'all') {
          carList =
              carList.where((car) => car.carCompany == companyCar).toList();
        }

        if (transmission != null &&
            transmission.isNotEmpty &&
            transmission != 'all') {
          carList =
              carList.where((car) => car.transmission == transmission).toList();
        }

        return carList;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
